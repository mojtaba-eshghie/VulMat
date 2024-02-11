// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/Bytes.sol

pragma solidity ^0.5.10;

contract Bytes {
    function scriptNumSize(uint256 i) public pure returns (uint256) {
        if      (i > 0x7fffffff) { return 5; }
        else if (i > 0x7fffff  ) { return 4; }
        else if (i > 0x7fff    ) { return 3; }
        else if (i > 0x7f      ) { return 2; }
        else if (i > 0x00      ) { return 1; }
        else                     { return 0; }
    }

    function scriptNumSizeHex(uint256 i) public pure returns (bytes memory) {
        return toBytes(scriptNumSize(i));
    }

    function toBytes(uint256 x) public pure returns (bytes memory b) {
        uint a = scriptNumSize(x);
        b = new bytes(a);
        for (uint i = 0; i < a; i++) {
            b[i] = byte(uint8(x / (2**(8*(a - 1 - i)))));
        }
    }

    function scriptNumEncode(uint256 num) public pure returns (bytes memory) {
        uint a = scriptNumSize(num);
        bytes memory b = toBytes(num);
        for (uint i = 0; i < (a/2); i++) {
            byte c = b[i];
            b[i] = b[a - i - 1];
            b[a - i - 1] = c;
        }
        return b;
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/LoansInterface.sol

pragma solidity ^0.5.10;

interface LoansInterface {
    function secretHashes(bytes32) external view returns (bytes32, bytes32, bytes32, bytes32, bytes32, bool);
    function pubKeys(bytes32) external view returns (bytes memory, bytes memory, bytes memory);
    function liquidationExpiration(bytes32) external view returns (uint256);
    function seizureExpiration(bytes32) external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/P2WSH.sol

pragma solidity ^0.5.10;

contract P2WSH is Bytes {
  LoansInterface loans;

  constructor(LoansInterface loans_) public {
    loans = loans_;
  }

  function loanPeriodP2WSH(bytes32 loan, bytes memory script) internal view returns (bytes memory) {
    (, bytes32 secretHashB1, bytes32 secretHashC1, , ,) = loans.secretHashes(loan);
    (bytes memory borrowerPubKey, ,) = loans.pubKeys(loan);

    bytes memory result = abi.encodePacked(
      hex"63820120877ca820", // OP_IF OP_SIZE OP_PUSHDATA(1) OP_PUSHDATA(32) OP_EQUAL OP_SWAP OP_SHA256 OP_PUSHDATA(32)
      secretHashB1,
      hex"879352877c820120877ca820", // OP_EQUAL OP_ADD OP_2 OP_EQUAL OP_SWAP OP_SIZE OP_PUSHDATA(1) OP_PUSHDATA(32) OP_EQUAL OP_SWAP OP_SHA256 OP_PUSHDATA(32)
      secretHashC1,
      hex"879352879351a26976a914", // OP_EQUAL OP_ADD OP_2 OP_EQUAL OP_ADD OP_1 OP_GREATERTHANOREQUAL OP_VERIFY OP_DUP OP_HASH160 OP_PUSHDATA(20)
      ripemd160(abi.encodePacked(sha256(borrowerPubKey))),
      hex"88ac67", // OP_EQUALVERIFY OP_CHECKSIG OP_ELSE
      script,
      hex"68" // OP_ENDIF
    );

    return result;
  }

  function biddingPeriodSigP2WSH(bytes32 loan) internal view returns (bytes memory) {
    (bytes memory borrowerPubKey, bytes memory lenderPubKey, bytes memory arbiterPubKey) = loans.pubKeys(loan);

    bytes memory result = abi.encodePacked(
      hex"52", // OP_2
      toBytes(borrowerPubKey.length),
      borrowerPubKey,
      toBytes(lenderPubKey.length),
      lenderPubKey,
      toBytes(arbiterPubKey.length),
      arbiterPubKey,
      hex"53ae" // OP_3 CHECKMULTISIG
    );

    return result;
  }

  function biddingPeriodP2WSH(bytes32 loan, bytes memory script) internal view returns (bytes memory) {
    bytes memory result = abi.encodePacked(
      hex"63", // OP_IF
      biddingPeriodSigP2WSH(loan),
      hex"67", // OP_ELSE
      script,
      hex"68" // OP_ENDIF
    );

    return result;
  }

  function seizurePeriodSechP2WSH(bytes32 loan) internal view returns (bytes memory) {
    (bytes32 secretHashA1,,,,,) = loans.secretHashes(loan);
    uint256 liquidationExpiration = loans.liquidationExpiration(loan);

    bytes memory result = abi.encodePacked(
      hex"82012088a820", // OP_SIZE OP_PUSHDATA(1) OP_PUSHDATA(32) OP_EQUALVERIFY OP_SHA256 OP_PUSHDATA(32)
      secretHashA1,
      hex"88", // OP_EQUALVERIFY
      scriptNumSizeHex(liquidationExpiration),
      scriptNumEncode(liquidationExpiration),
      hex"b175" // OP_CHECKLOCKTIMEVERIFY OP_DROP
    );

    return result;
  }

  function seizurePeriodP2WSH(bytes32 loan, bytes memory script, bool sez) internal view returns (bytes memory) {
    (bytes memory borrowerPubKey, bytes memory lenderPubKey, ) = loans.pubKeys(loan);

    bytes memory pubKey;

    if (sez) {
      pubKey = lenderPubKey;
    } else {
      pubKey = borrowerPubKey;
    }

    bytes memory result = abi.encodePacked(
      hex"63", // OP_IF
      seizurePeriodSechP2WSH(loan),
      hex"76a914", // OP_DUP OP_HASH160 OP_PUSHDATA(20)
      ripemd160(abi.encodePacked(sha256(pubKey))),
      hex"88ac67", // OP_EQUALVERIFY OP_CHECKSIG OP_ELSE
      script,
      hex"68" // OP_ENDIF
    );

    return result;
  }

  function refundablePeriodP2WSH(bytes32 loan) internal view returns (bytes memory) {
    (bytes memory borrowerPubKey, , ) = loans.pubKeys(loan);
    uint256 seizureExpiration = loans.seizureExpiration(loan);

    bytes memory result = abi.encodePacked(
      scriptNumSizeHex(seizureExpiration),
      scriptNumEncode(seizureExpiration),
      hex"b17576a914", // OP_CHECKLOCKTIMEVERIFY OP_DROP OP_DUP OP_HASH160 OP_PUSHDATA(20)
      ripemd160(abi.encodePacked(sha256(borrowerPubKey))),
      hex"88ac" // OP_EQUALVERIFY OP_CHECKSIG
    );

    return result;
  }

  function getP2WSH(bytes32 loan, bool sez) public view returns (bytes memory, bytes32) {
    bytes memory script = loanPeriodP2WSH(loan, biddingPeriodP2WSH(loan, seizurePeriodP2WSH(loan, refundablePeriodP2WSH(loan), sez)));
    bytes32 pubkh = sha256(script);

    return (script, pubkh);
  }
}
