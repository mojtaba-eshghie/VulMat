// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/ownership/Ownable.sol

pragma solidity ^0.4.24;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing to ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function transferOwnership(address _newOwner) public onlyOwner {
    _transferOwnership(_newOwner);
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address _newOwner) internal {
    require(_newOwner != address(0));
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/access/rbac/Roles.sol

pragma solidity ^0.4.24;


/**
 * @title Roles
 * @author Francisco Giordano (@frangio)
 * @dev Library for managing addresses assigned to a Role.
 * See RBAC.sol for example usage.
 */
library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }

  /**
   * @dev give an address access to this role
   */
  function add(Role storage _role, address _addr)
    internal
  {
    _role.bearer[_addr] = true;
  }

  /**
   * @dev remove an address' access to this role
   */
  function remove(Role storage _role, address _addr)
    internal
  {
    _role.bearer[_addr] = false;
  }

  /**
   * @dev check if an address has this role
   * // reverts
   */
  function check(Role storage _role, address _addr)
    internal
    view
  {
    require(has(_role, _addr));
  }

  /**
   * @dev check if an address has this role
   * @return bool
   */
  function has(Role storage _role, address _addr)
    internal
    view
    returns (bool)
  {
    return _role.bearer[_addr];
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/access/rbac/RBAC.sol

pragma solidity ^0.4.24;

/**
 * @title RBAC (Role-Based Access Control)
 * @author Matt Condon (@Shrugs)
 * @dev Stores and provides setters and getters for roles and addresses.
 * Supports unlimited numbers of roles and addresses.
 * See //contracts/mocks/RBACMock.sol for an example of usage.
 * This RBAC method uses strings to key roles. It may be beneficial
 * for you to write your own implementation of this interface using Enums or similar.
 */
contract RBAC {
  using Roles for Roles.Role;

  mapping (string => Roles.Role) private roles;

  event RoleAdded(address indexed operator, string role);
  event RoleRemoved(address indexed operator, string role);

  /**
   * @dev reverts if addr does not have role
   * @param _operator address
   * @param _role the name of the role
   * // reverts
   */
  function checkRole(address _operator, string _role)
    public
    view
  {
    roles[_role].check(_operator);
  }

  /**
   * @dev determine if addr has role
   * @param _operator address
   * @param _role the name of the role
   * @return bool
   */
  function hasRole(address _operator, string _role)
    public
    view
    returns (bool)
  {
    return roles[_role].has(_operator);
  }

  /**
   * @dev add a role to an address
   * @param _operator address
   * @param _role the name of the role
   */
  function addRole(address _operator, string _role)
    internal
  {
    roles[_role].add(_operator);
    emit RoleAdded(_operator, _role);
  }

  /**
   * @dev remove a role from an address
   * @param _operator address
   * @param _role the name of the role
   */
  function removeRole(address _operator, string _role)
    internal
  {
    roles[_role].remove(_operator);
    emit RoleRemoved(_operator, _role);
  }

  /**
   * @dev modifier to scope access to a single role (uses msg.sender as addr)
   * @param _role the name of the role
   * // reverts
   */
  modifier onlyRole(string _role)
  {
    checkRole(msg.sender, _role);
    _;
  }


  /**
   * @dev modifier to scope access to a set of roles (uses msg.sender as addr)
   * @param _roles the names of the roles to scope access to
   * // reverts
   *
   * @TODO - when solidity supports dynamic arrays as arguments to modifiers, provide this
   *  see: https://github.com/ethereum/solidity/issues/2467
   */
  // modifier onlyRoles(string[] _roles) {
  //     bool hasAnyRole = false;
  //     for (uint8 i = 0; i < _roles.length; i++) {
  //         if (hasRole(msg.sender, _roles[i])) {
  //             hasAnyRole = true;
  //             break;
  //         }
  //     }

  //     require(hasAnyRole);

  //     _;
  // }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/ECRecovery.sol

pragma solidity ^0.4.24;


/**
 * @title Elliptic curve signature operations
 * @dev Based on https://gist.github.com/axic/5b33912c6f61ae6fd96d6c4a47afde6d
 * TODO Remove this library once solidity supports passing a signature to ecrecover.
 * See https://github.com/ethereum/solidity/issues/864
 */

library ECRecovery {

  /**
   * @dev Recover signer address from a message by using their signature
   * @param _hash bytes32 message, the hash is the signed message. What is recovered is the signer address.
   * @param _sig bytes signature, the signature is generated using web3.eth.sign()
   */
  function recover(bytes32 _hash, bytes _sig)
    internal
    pure
    returns (address)
  {
    bytes32 r;
    bytes32 s;
    uint8 v;

    // Check the signature length
    if (_sig.length != 65) {
      return (address(0));
    }

    // Divide the signature in r, s and v variables
    // ecrecover takes the signature parameters, and the only way to get them
    // currently is to use assembly.
    // solium-disable-next-line security/no-inline-assembly
    assembly {
      r := mload(add(_sig, 32))
      s := mload(add(_sig, 64))
      v := byte(0, mload(add(_sig, 96)))
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
      return ecrecover(_hash, v, r, s);
    }
  }

  /**
   * toEthSignedMessageHash
   * @dev prefix a bytes32 value with "\x19Ethereum Signed Message:"
   * and hash the result
   */
  function toEthSignedMessageHash(bytes32 _hash)
    internal
    pure
    returns (bytes32)
  {
    // 32 is the length in bytes of hash,
    // enforced by the type signature above
    return keccak256(
      abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash)
    );
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/access/SignatureBouncer.sol

pragma solidity ^0.4.24;



/**
 * @title SignatureBouncer
 * @author PhABC, Shrugs and aflesher
 * @dev Bouncer allows users to submit a signature as a permission to do an action.
 * If the signature is from one of the authorized bouncer addresses, the signature
 * is valid. The owner of the contract adds/removes bouncers.
 * Bouncer addresses can be individual servers signing grants or different
 * users within a decentralized club that have permission to invite other members.
 * This technique is useful for whitelists and airdrops; instead of putting all
 * valid addresses on-chain, simply sign a grant of the form
 * keccak256(abi.encodePacked(`:contractAddress` + `:granteeAddress`)) using a valid bouncer address.
 * Then restrict access to your crowdsale/whitelist/airdrop using the
 * `onlyValidSignature` modifier (or implement your own using isValidSignature).
 * In addition to `onlyValidSignature`, `onlyValidSignatureAndMethod` and
 * `onlyValidSignatureAndData` can be used to restrict access to only a given method
 * or a given method with given parameters respectively.
 * See the tests Bouncer.test.js for specific usage examples.
 * @notice A method that uses the `onlyValidSignatureAndData` modifier must make the _sig
 * parameter the "last" parameter. You cannot sign a message that has its own
 * signature in it so the last 128 bytes of msg.data (which represents the
 * length of the _sig data and the _sig data itself) is ignored when validating.
 * Also non fixed sized parameters make constructing the data in the signature
 * much more complex. See https://ethereum.stackexchange.com/a/50616 for more details.
 */
contract SignatureBouncer is Ownable, RBAC {
  using ECRecovery for bytes32;

  string public constant ROLE_BOUNCER = "bouncer";
  uint constant METHOD_ID_SIZE = 4;
  // signature size is 65 bytes (tightly packed v + r + s), but gets padded to 96 bytes
  uint constant SIGNATURE_SIZE = 96;

  /**
   * @dev requires that a valid signature of a bouncer was provided
   */
  modifier onlyValidSignature(bytes _sig)
  {
    require(isValidSignature(msg.sender, _sig));
    _;
  }

  /**
   * @dev requires that a valid signature with a specifed method of a bouncer was provided
   */
  modifier onlyValidSignatureAndMethod(bytes _sig)
  {
    require(isValidSignatureAndMethod(msg.sender, _sig));
    _;
  }

  /**
   * @dev requires that a valid signature with a specifed method and params of a bouncer was provided
   */
  modifier onlyValidSignatureAndData(bytes _sig)
  {
    require(isValidSignatureAndData(msg.sender, _sig));
    _;
  }

  /**
   * @dev allows the owner to add additional bouncer addresses
   */
  function addBouncer(address _bouncer)
    public
    onlyOwner
  {
    require(_bouncer != address(0));
    addRole(_bouncer, ROLE_BOUNCER);
  }

  /**
   * @dev allows the owner to remove bouncer addresses
   */
  function removeBouncer(address _bouncer)
    public
    onlyOwner
  {
    require(_bouncer != address(0));
    removeRole(_bouncer, ROLE_BOUNCER);
  }

  /**
   * @dev is the signature of `this + sender` from a bouncer?
   * @return bool
   */
  function isValidSignature(address _address, bytes _sig)
    internal
    view
    returns (bool)
  {
    return isValidDataHash(
      keccak256(abi.encodePacked(address(this), _address)),
      _sig
    );
  }

  /**
   * @dev is the signature of `this + sender + methodId` from a bouncer?
   * @return bool
   */
  function isValidSignatureAndMethod(address _address, bytes _sig)
    internal
    view
    returns (bool)
  {
    bytes memory data = new bytes(METHOD_ID_SIZE);
    for (uint i = 0; i < data.length; i++) {
      data[i] = msg.data[i];
    }
    return isValidDataHash(
      keccak256(abi.encodePacked(address(this), _address, data)),
      _sig
    );
  }

  /**
    * @dev is the signature of `this + sender + methodId + params(s)` from a bouncer?
    * @notice the _sig parameter of the method being validated must be the "last" parameter
    * @return bool
    */
  function isValidSignatureAndData(address _address, bytes _sig)
    internal
    view
    returns (bool)
  {
    require(msg.data.length > SIGNATURE_SIZE);
    bytes memory data = new bytes(msg.data.length - SIGNATURE_SIZE);
    for (uint i = 0; i < data.length; i++) {
      data[i] = msg.data[i];
    }
    return isValidDataHash(
      keccak256(abi.encodePacked(address(this), _address, data)),
      _sig
    );
  }

  /**
   * @dev internal function to convert a hash to an eth signed message
   * and then recover the signature and check it against the bouncer role
   * @return bool
   */
  function isValidDataHash(bytes32 _hash, bytes _sig)
    internal
    view
    returns (bool)
  {
    address signer = _hash
      .toEthSignedMessageHash()
      .recover(_sig);
    return hasRole(signer, ROLE_BOUNCER);
  }
}
