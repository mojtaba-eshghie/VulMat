// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/access/Roles.sol

pragma solidity ^0.4.24;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }

  /**
   * @dev give an account access to this role
   */
  function add(Role storage role, address account) internal {
    require(account != address(0));
    require(!has(role, account));

    role.bearer[account] = true;
  }

  /**
   * @dev remove an account's access to this role
   */
  function remove(Role storage role, address account) internal {
    require(account != address(0));
    require(has(role, account));

    role.bearer[account] = false;
  }

  /**
   * @dev check if an account has this role
   * @return bool
   */
  function has(Role storage role, address account)
    internal
    view
    returns (bool)
  {
    require(account != address(0));
    return role.bearer[account];
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/access/roles/SignerRole.sol

pragma solidity ^0.4.24;

contract SignerRole {
  using Roles for Roles.Role;

  event SignerAdded(address indexed account);
  event SignerRemoved(address indexed account);

  Roles.Role private signers;

  constructor() internal {
    _addSigner(msg.sender);
  }

  modifier onlySigner() {
    require(isSigner(msg.sender));
    _;
  }

  function isSigner(address account) public view returns (bool) {
    return signers.has(account);
  }

  function addSigner(address account) public onlySigner {
    _addSigner(account);
  }

  function renounceSigner() public {
    _removeSigner(msg.sender);
  }

  function _addSigner(address account) internal {
    signers.add(account);
    emit SignerAdded(account);
  }

  function _removeSigner(address account) internal {
    signers.remove(account);
    emit SignerRemoved(account);
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/cryptography/ECDSA.sol

pragma solidity ^0.4.24;

/**
 * @title Elliptic curve signature operations
 * @dev Based on https://gist.github.com/axic/5b33912c6f61ae6fd96d6c4a47afde6d
 * TODO Remove this library once solidity supports passing a signature to ecrecover.
 * See https://github.com/ethereum/solidity/issues/864
 */

library ECDSA {

  /**
   * @dev Recover signer address from a message by using their signature
   * @param hash bytes32 message, the hash is the signed message. What is recovered is the signer address.
   * @param signature bytes signature, the signature is generated using web3.eth.sign()
   */
  function recover(bytes32 hash, bytes signature)
    internal
    pure
    returns (address)
  {
    bytes32 r;
    bytes32 s;
    uint8 v;

    // Check the signature length
    if (signature.length != 65) {
      return (address(0));
    }

    // Divide the signature in r, s and v variables
    // ecrecover takes the signature parameters, and the only way to get them
    // currently is to use assembly.
    // solium-disable-next-line security/no-inline-assembly
    assembly {
      r := mload(add(signature, 0x20))
      s := mload(add(signature, 0x40))
      v := byte(0, mload(add(signature, 0x60)))
    }

    // Version of signature should be 27 or 28, but 0 and 1 are also possible versions
    if (v < 27) {
      v += 27;
    }

    // If the version is correct return the signer address
    if (v != 27 && v != 28) {
      return (address(0));
    } else {
      // solium-disable-next-line arg-overflow
      return ecrecover(hash, v, r, s);
    }
  }

  /**
   * toEthSignedMessageHash
   * @dev prefix a bytes32 value with "\x19Ethereum Signed Message:"
   * and hash the result
   */
  function toEthSignedMessageHash(bytes32 hash)
    internal
    pure
    returns (bytes32)
  {
    // 32 is the length in bytes of hash,
    // enforced by the type signature above
    return keccak256(
      abi.encodePacked("\x19Ethereum Signed Message:\n32", hash)
    );
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/drafts/SignatureBouncer.sol

pragma solidity ^0.4.24;


/**
 * @title SignatureBouncer
 * @author PhABC, Shrugs and aflesher
 * @dev SignatureBouncer allows users to submit a signature as a permission to
 * do an action.
 * If the signature is from one of the authorized signer addresses, the
 * signature is valid.
 * Note that SignatureBouncer offers no protection against replay attacks, users
 * must add this themselves!
 *
 * Signer addresses can be individual servers signing grants or different
 * users within a decentralized club that have permission to invite other
 * members. This technique is useful for whitelists and airdrops; instead of
 * putting all valid addresses on-chain, simply sign a grant of the form
 * keccak256(abi.encodePacked(`:contractAddress` + `:granteeAddress`)) using a
 * valid signer address.
 * Then restrict access to your crowdsale/whitelist/airdrop using the
 * `onlyValidSignature` modifier (or implement your own using _isValidSignature).
 * In addition to `onlyValidSignature`, `onlyValidSignatureAndMethod` and
 * `onlyValidSignatureAndData` can be used to restrict access to only a given
 * method or a given method with given parameters respectively.
 * See the tests in SignatureBouncer.test.js for specific usage examples.
 *
 * @notice A method that uses the `onlyValidSignatureAndData` modifier must make
 * the _signature parameter the "last" parameter. You cannot sign a message that
 * has its own signature in it so the last 128 bytes of msg.data (which
 * represents the length of the _signature data and the _signaature data itself)
 * is ignored when validating. Also non fixed sized parameters make constructing
 * the data in the signature much more complex.
 * See https://ethereum.stackexchange.com/a/50616 for more details.
 */
contract SignatureBouncer is SignerRole {
  using ECDSA for bytes32;

  // Function selectors are 4 bytes long, as documented in
  // https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector
  uint256 private constant _METHOD_ID_SIZE = 4;
  // Signature size is 65 bytes (tightly packed v + r + s), but gets padded to 96 bytes
  uint256 private constant _SIGNATURE_SIZE = 96;

  constructor() internal {}

  /**
   * @dev requires that a valid signature of a signer was provided
   */
  modifier onlyValidSignature(bytes signature)
  {
    require(_isValidSignature(msg.sender, signature));
    _;
  }

  /**
   * @dev requires that a valid signature with a specifed method of a signer was provided
   */
  modifier onlyValidSignatureAndMethod(bytes signature)
  {
    require(_isValidSignatureAndMethod(msg.sender, signature));
    _;
  }

  /**
   * @dev requires that a valid signature with a specifed method and params of a signer was provided
   */
  modifier onlyValidSignatureAndData(bytes signature)
  {
    require(_isValidSignatureAndData(msg.sender, signature));
    _;
  }

  /**
   * @dev is the signature of `this + sender` from a signer?
   * @return bool
   */
  function _isValidSignature(address account, bytes signature)
    internal
    view
    returns (bool)
  {
    return _isValidDataHash(
      keccak256(abi.encodePacked(address(this), account)),
      signature
    );
  }

  /**
   * @dev is the signature of `this + sender + methodId` from a signer?
   * @return bool
   */
  function _isValidSignatureAndMethod(address account, bytes signature)
    internal
    view
    returns (bool)
  {
    bytes memory data = new bytes(_METHOD_ID_SIZE);
    for (uint i = 0; i < data.length; i++) {
      data[i] = msg.data[i];
    }
    return _isValidDataHash(
      keccak256(abi.encodePacked(address(this), account, data)),
      signature
    );
  }

  /**
    * @dev is the signature of `this + sender + methodId + params(s)` from a signer?
    * @notice the signature parameter of the method being validated must be the "last" parameter
    * @return bool
    */
  function _isValidSignatureAndData(address account, bytes signature)
    internal
    view
    returns (bool)
  {
    require(msg.data.length > _SIGNATURE_SIZE);
    bytes memory data = new bytes(msg.data.length - _SIGNATURE_SIZE);
    for (uint i = 0; i < data.length; i++) {
      data[i] = msg.data[i];
    }
    return _isValidDataHash(
      keccak256(abi.encodePacked(address(this), account, data)),
      signature
    );
  }

  /**
   * @dev internal function to convert a hash to an eth signed message
   * and then recover the signature and check it against the signer role
   * @return bool
   */
  function _isValidDataHash(bytes32 hash, bytes signature)
    internal
    view
    returns (bool)
  {
    address signer = hash
      .toEthSignedMessageHash()
      .recover(signature);

    return signer != address(0) && isSigner(signer);
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/mocks/SignerRoleMock.sol

pragma solidity ^0.4.24;

contract SignerRoleMock is SignerRole {
  function removeSigner(address account) public {
    _removeSigner(account);
  }

  function onlySignerMock() public view onlySigner {
  }

  // Causes a compilation error if super._removeSigner is not internal
  function _removeSigner(address account) internal {
    super._removeSigner(account);
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/mocks/SignatureBouncerMock.sol

pragma solidity ^0.4.24;


contract SignatureBouncerMock is SignatureBouncer, SignerRoleMock {
  function checkValidSignature(address account, bytes signature)
    public
    view
    returns (bool)
  {
    return _isValidSignature(account, signature);
  }

  function onlyWithValidSignature(bytes signature)
    public
    onlyValidSignature(signature)
    view
  {

  }

  function checkValidSignatureAndMethod(address account, bytes signature)
    public
    view
    returns (bool)
  {
    return _isValidSignatureAndMethod(account, signature);
  }

  function onlyWithValidSignatureAndMethod(bytes signature)
    public
    onlyValidSignatureAndMethod(signature)
    view
  {

  }

  function checkValidSignatureAndData(
    address account,
    bytes,
    uint,
    bytes signature
  )
    public
    view
    returns (bool)
  {
    return _isValidSignatureAndData(account, signature);
  }

  function onlyWithValidSignatureAndData(uint, bytes signature)
    public
    onlyValidSignatureAndData(signature)
    view
  {

  }

  function theWrongMethod(bytes)
    public
    pure
  {

  }

  function tooShortMsgData()
    public
    onlyValidSignatureAndData("")
    view
  {
  }
}
