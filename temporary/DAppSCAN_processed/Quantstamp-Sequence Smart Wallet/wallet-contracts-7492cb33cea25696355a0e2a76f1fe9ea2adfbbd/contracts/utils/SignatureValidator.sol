// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/interfaces/IERC1271Wallet.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


interface IERC1271Wallet {

  /**
   * @notice Verifies whether the provided signature is valid with respect to the provided data
   * @dev MUST return the correct magic value if the signature provided is valid for the provided data
   *   > The bytes4 magic value to return when signature is valid is 0x20c13b0b : bytes4(keccak256("isValidSignature(bytes,bytes)")
   *   > This function MAY modify Ethereum's state
   * @param _data       Arbitrary length data signed on the behalf of address(this)
   * @param _signature  Signature byte array associated with _data
   * @return magicValue Magic value 0x20c13b0b if the signature is valid and 0x0 otherwise
   */
  function isValidSignature(
    bytes calldata _data,
    bytes calldata _signature)
    external
    view
    returns (bytes4 magicValue);

  /**
   * @notice Verifies whether the provided signature is valid with respect to the provided hash
   * @dev MUST return the correct magic value if the signature provided is valid for the provided hash
   *   > The bytes4 magic value to return when signature is valid is 0x20c13b0b : bytes4(keccak256("isValidSignature(bytes,bytes)")
   *   > This function MAY modify Ethereum's state
   * @param _hash       keccak256 hash that was signed
   * @param _signature  Signature byte array associated with _data
   * @return magicValue Magic value 0x20c13b0b if the signature is valid and 0x0 otherwise
   */
  function isValidSignature(
    bytes32 _hash,
    bytes calldata _signature)
    external
    view
    returns (bytes4 magicValue);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/utils/LibBytes.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;

library LibBytes {
  using LibBytes for bytes;

  /***********************************|
  |        Read Bytes Functions       |
  |__________________________________*/

  /**
   * @dev Read firsts uint16 value.
   * @param data Byte array to be read.
   * @return a uint16 value of data at index zero.
   * @return newIndex Updated index after reading the values.
   */
  function readFirstUint16(
    bytes memory data
  ) internal pure returns (
    uint16 a,
    uint256 newIndex
  ) {
    assembly {
      let word := mload(add(32, data))
      a := shr(240, word)
      newIndex := 2
    }
    require(2 <= data.length, "LibBytes#readFirstUint16: OUT_OF_BOUNDS");
  }

  /**
   * @dev Reads consecutive bool (8 bits) and uint8 values.
   * @param data Byte array to be read.
   * @param index Index in byte array of uint8 and uint8 values.
   * @return a uint8 value of data at given index.
   * @return b uint8 value of data at given index + 8.
   * @return newIndex Updated index after reading the values.
   */
  function readUint8Uint8(
    bytes memory data,
    uint256 index
  ) internal pure returns (
    uint8 a,
    uint8 b,
    uint256 newIndex
  ) {
    assembly {
      let word := mload(add(index, add(32, data)))
      a := shr(248, word)
      b := and(shr(240, word), 0xff)
      newIndex := add(index, 2)
    }
    require(newIndex <= data.length, "LibBytes#readUint8Uint8: OUT_OF_BOUNDS");
  }

  /**
   * @dev Reads an address value from a position in a byte array.
   * @param data Byte array to be read.
   * @param index Index in byte array of address value.
   * @return a address value of data at given index.
   * @return newIndex Updated index after reading the value.
   */
  function readAddress(
    bytes memory data,
    uint256 index
  ) internal pure returns (
    address a,
    uint256 newIndex
  ) {
    assembly {
      let word := mload(add(index, add(32, data)))
      a := and(shr(96, word), 0xffffffffffffffffffffffffffffffffffffffff)
      newIndex := add(index, 20)
    }
    require(newIndex <= data.length, "LibBytes#readAddress: OUT_OF_BOUNDS");
  }

  /**
   * @dev Reads 66 bytes from a position in a byte array.
   * @param data Byte array to be read.
   * @param index Index in byte array of 66 bytes value.
   * @return a 66 bytes bytes array value of data at given index.
   * @return newIndex Updated index after reading the value.
   */
  function readBytes66(
    bytes memory data,
    uint256 index
  ) internal pure returns (
    bytes memory a,
    uint256 newIndex
  ) {
    a = new bytes(66);
    assembly {
      let offset := add(32, add(data, index))
      mstore(add(a, 32), mload(offset))
      mstore(add(a, 64), mload(add(offset, 32)))
      mstore(add(a, 66), mload(add(offset, 34)))
      newIndex := add(index, 66)
    }
    require(newIndex <= data.length, "LibBytes#readBytes66: OUT_OF_BOUNDS");
  }

  /**
   * @dev Reads a bytes32 value from a position in a byte array.
   * @param b Byte array containing a bytes32 value.
   * @param index Index in byte array of bytes32 value.
   * @return result bytes32 value from byte array.
   */
  function readBytes32(
    bytes memory b,
    uint256 index
  )
    internal
    pure
    returns (bytes32 result)
  {
    require(
      b.length >= index + 32,
      "LibBytes#readBytes32: GREATER_OR_EQUAL_TO_32_LENGTH_REQUIRED"
    );

    // Arrays are prefixed by a 256 bit length parameter
    uint256 pos = index + 32;

    // Read the bytes32 from array memory
    assembly {
      result := mload(add(b, pos))
    }
    return result;
  }

  /**
   * @dev Reads an uint16 value from a position in a byte array.
   * @param data Byte array to be read.
   * @param index Index in byte array of uint16 value.
   * @return a uint16 value of data at given index.
   * @return newIndex Updated index after reading the value.
   */
  function readUint16(
    bytes memory data,
    uint256 index
  ) internal pure returns (uint16 a, uint256 newIndex) {
    assembly {
      let word := mload(add(index, add(32, data)))
      a := and(shr(240, word), 0xffff)
      //SWC-Integer Overflow and Underflow: L147
      newIndex := add(index, 2)
    }
    require(newIndex <= data.length, "LibBytes#readUint16: OUT_OF_BOUNDS");
  }

  /**
   * @dev Reads bytes from a position in a byte array.
   * @param data Byte array to be read.
   * @param index Index in byte array of bytes value.
   * @param size Number of bytes to read.
   * @return a bytes bytes array value of data at given index.
   * @return newIndex Updated index after reading the value.
   */
  function readBytes(
    bytes memory data,
    uint256 index,
    uint256 size
  ) internal pure returns (bytes memory a, uint256 newIndex) {
    a = new bytes(size);

    assembly {
      let offset := add(32, add(data, index))

      let i := 0 let n := 32
      // Copy each word, except last one
      for { } lt(n, size) { i := n n := add(n, 32) } {
        mstore(add(a, n), mload(add(offset, i)))
      }

      // Load word after new array
      let suffix := add(a, add(32, size))
      let suffixWord := mload(suffix)

      // Copy last word, overwrites after array 
      mstore(add(a, n), mload(add(offset, i)))

      // Restore after array
      mstore(suffix, suffixWord)

      newIndex := add(index, size)
    }

    require(newIndex <= data.length, "LibBytes#readBytes: OUT_OF_BOUNDS");
  }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/utils/SignatureValidator.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;

/**
 * @dev Contains logic for signature validation.
 * Signatures from wallet contracts assume ERC-1271 support (https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1271.md)
 * Notes: Methods are strongly inspired by contracts in https://github.com/0xProject/0x-monorepo/blob/development/
 */
contract SignatureValidator {
  using LibBytes for bytes;

  /***********************************|
  |             Variables             |
  |__________________________________*/

  // bytes4(keccak256("isValidSignature(bytes,bytes)"))
  bytes4 constant internal ERC1271_MAGICVALUE = 0x20c13b0b;

  // bytes4(keccak256("isValidSignature(bytes32,bytes)"))
  bytes4 constant internal ERC1271_MAGICVALUE_BYTES32 = 0x1626ba7e;

  // Allowed signature types.
  uint256 private constant SIG_TYPE_EIP712 = 1;
  uint256 private constant SIG_TYPE_ETH_SIGN = 2;
  uint256 private constant SIG_TYPE_WALLET_BYTES32 = 3;

  /***********************************|
  |        Signature Functions        |
  |__________________________________*/

 /**
   * @notice Recover the signer of hash, assuming it's an EOA account
   * @dev Only for SignatureType.EIP712 and SignatureType.EthSign signatures
   * @param _hash      Hash that was signed
   *   encoded as (bytes32 r, bytes32 s, uint8 v, ... , SignatureType sigType)
   */
  function recoverSigner(
    bytes32 _hash,
    bytes memory _signature
  ) internal pure returns (address signer) {
    uint256 signatureType = uint8(_signature[_signature.length - 1]);

    // Variables are not scoped in Solidity.
    uint8 v = uint8(_signature[64]);
    bytes32 r = _signature.readBytes32(0);
    bytes32 s = _signature.readBytes32(32);

    // EIP-2 still allows signature malleability for ecrecover(). Remove this possibility and make the signature
    // unique. Appendix F in the Ethereum Yellow paper (https://ethereum.github.io/yellowpaper/paper.pdf), defines
    // the valid range for s in (281): 0 < s < secp256k1n ÷ 2 + 1, and for v in (282): v ∈ {27, 28}. Most
    // signatures from current libraries generate a unique signature with an s-value in the lower half order.
    //
    // If your library generates malleable signatures, such as s-values in the upper range, calculate a new s-value
    // with 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - s1 and flip v from 27 to 28 or
    // vice versa. If your library also generates signatures with 0/1 for v instead 27/28, add 27 to v to accept
    // these malleable signatures as well.
    //
    // Source OpenZeppelin
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/cryptography/ECDSA.sol

    if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
      revert("SignatureValidator#recoverSigner: invalid signature 's' value");
    }

    if (v != 27 && v != 28) {
      revert("SignatureValidator#recoverSigner: invalid signature 'v' value");
    }

    // Signature using EIP712
    if (signatureType == SIG_TYPE_EIP712) {
      signer = ecrecover(_hash, v, r, s);

    // Signed using web3.eth_sign() or Ethers wallet.signMessage()
    } else if (signatureType == SIG_TYPE_ETH_SIGN) {
      signer = ecrecover(
        keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash)),
        v,
        r,
        s
      );

    } else {
      // Anything other signature types are illegal (We do not return false because
      // the signature may actually be valid, just not in a format
      // that we currently support. In this case returning false
      // may lead the caller to incorrectly believe that the
      // signature was invalid.)
      revert("SignatureValidator#recoverSigner: UNSUPPORTED_SIGNATURE_TYPE");
    }

    // Prevent signer from being 0x0
    require(
      signer != address(0x0),
      "SignatureValidator#recoverSigner: INVALID_SIGNER"
    );

    return signer;
  }

 /**
   * @notice Returns true if the provided signature is valid for the given signer.
   * @dev Supports SignatureType.EIP712, SignatureType.EthSign, and ERC1271 signatures
   * @param _hash      Hash that was signed
   * @param _signer    Address of the signer candidate
   * @param _signature Signature byte array
   */
  function isValidSignature(
    bytes32 _hash,
    address _signer,
    bytes memory _signature
  ) internal view returns (bool valid) {
    uint256 signatureType = uint8(_signature[_signature.length - 1]);

    if (signatureType == SIG_TYPE_EIP712 || signatureType == SIG_TYPE_ETH_SIGN) {
      // Recover signer and compare with provided
      valid = recoverSigner(_hash, _signature) == _signer;

    } else if (signatureType == SIG_TYPE_WALLET_BYTES32) {
      // Remove signature type before calling ERC1271, restore after call
      uint256 prevSize; assembly { prevSize := mload(_signature) mstore(_signature, sub(prevSize, 1)) }
      valid = ERC1271_MAGICVALUE_BYTES32 == IERC1271Wallet(_signer).isValidSignature(_hash, _signature);
      assembly { mstore(_signature, prevSize) }

    } else {
      // Anything other signature types are illegal (We do not return false because
      // the signature may actually be valid, just not in a format
      // that we currently support. In this case returning false
      // may lead the caller to incorrectly believe that the
      // signature was invalid.)
      revert("SignatureValidator#isValidSignature: UNSUPPORTED_SIGNATURE_TYPE");
    }
  }
}
