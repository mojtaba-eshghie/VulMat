// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Assertive.sol

pragma solidity ^0.4.18;
contract Assertive {
  function assert(bool assertion) {
    if (!assertion) throw;
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Owned.sol

pragma solidity ^0.4.18;

// @title Owned

contract Owned is Assertive {
  address internal owner;
  event SetOwner(address indexed previousOwner, address indexed newOwner);
  function Owned () {
    owner = msg.sender;
  }
  modifier onlyOwner {
    assert(msg.sender == owner);
    _;
  }
  function setOwner(address newOwner) onlyOwner {
    SetOwner(owner, newOwner);
    owner = newOwner;
  }
  function getOwner() returns (address out) {
    return owner;
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/StateTransferrable.sol

pragma solidity ^0.4.18;

contract StateTransferrable is Owned {
  bool internal locked;
  event Locked(address indexed from);
  event PropertySet(address indexed from);
  modifier onlyIfUnlocked {
    assert(!locked);
    _;
  }
  modifier setter {
    _;
    PropertySet(msg.sender);
  }
  modifier onlyOwnerUnlocked {
    assert(!locked && msg.sender == owner);
    _;
  }
  function lock() onlyOwner onlyIfUnlocked {
    locked = true;
    Locked(msg.sender);
  }
  function isLocked() returns (bool status) {
    return locked;
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Namereg.sol

pragma solidity ^0.4.18;

/**
 * @title Nameregistry contract to resolve
 *
 * @author Ray Pulver
 */
contract Namereg is StateTransferrable {

  event NameRegistered(bytes32 indexed name, address indexed addr, address indexed owner);
  event NameUnregistered(bytes32 indexed name);
  struct Record {
    address record;
    address owner;
    bool initialized;
  }
  mapping (bytes32 => Record) public registry;
  mapping (address => bytes32) public lookupTable;
  bytes32[] public registryIndex;
  mapping (bytes32 => bool) public registryActive;
  address[] public lookupIndex;
  mapping (address => bool) public lookupActive;

  function registerImpl(bytes32 name, address addr, address owner) internal returns (bool success) {
    activateName(name);
    activateAddress(addr);
    registry[name].record = addr;
    registry[name].owner = owner;
    registry[name].initialized = true;
    NameRegistered(name, addr, owner);
    return true;
  }

  function registerImplChecked(bytes32 name, address addr, address owner) internal returns (bool success) {
    assert(registry[name].initialized && registry[name].record == address(0x0) || registry[name].owner == owner);
    return registerImpl(name, addr, owner);
  }
    

  function unregisterImpl(bytes32 name, address caller) internal returns (bool success) {
    assert(registry[name].owner == caller);
    delete registry[name];
    NameUnregistered(name);
    return true;
  } 

  /**
   * @notice Register contract name  `${name}` for address `${address}`.
   *
   * @param name Name of the contract.
   * @param addr Address of the contract.
   *
   * @return result of operation, true or false
   */
  function register(bytes32 name, address addr) returns (bool success) {
    return registerImplChecked(name, addr, msg.sender);
  }

  /**
   * @notice Unregister contract by name `${name}`.
   *
   * @param name Name of the contract.
   * @return result of operation, true or false.
   */
  function unregister(bytes32 name) returns (bool success) {
    return unregisterImpl(name, msg.sender);
  }

  /**
   * @notice Unregister contract by address `${address}`
   *
   * @param addr Address to be unregistered
   * @return result of operation, true or false
   *
   */
  function unregisterAddr(address addr) onlyOwner returns (bool success) {
    bytes32 name = lookupTable[addr];
    return unregisterImpl(name, msg.sender);
  }

  /**
   * @notice Resolves contract by name `${name}`.
   *
   * @param name of the contract to be resolved
   * @return the address of the resolved contract
   */
  function resolve(bytes32 name) constant returns (address result) {
    return registry[name].record;
  }

  /**
    * @notice Resolves contract by address `${addr}`.
    *
    * @param addr of the contract to be resolved
    * @return the name of the resolved contract
    */
  function getName(address addr) returns (bytes32 result) {
    return lookupTable[addr];
  }

  function registerSelf(bytes32 name) returns (bool success) {
    assert(!registry[name].initialized || registry[name].owner == msg.sender);
    return registerImpl(name, msg.sender, msg.sender);
  }
    
  function extractRegistryIndexLength() returns (uint256 len) {
    return registryIndex.length;
  }

  function extractLookupIndexLength() returns (uint256 len) {
    return lookupIndex.length;
  }

  function extractRegistryRecord(bytes32 key) returns (address record) {
    return registry[key].record;
  }

  function extractRegistryOwner(bytes32 key) returns (address owner) {
    return registry[key].owner;
  }

  function extractRegistryInitialized(bytes32 key) returns (bool initialized) {
    return registry[key].initialized;
  }

  function activateName(bytes32 name) internal {
    if (!registryActive[name]) {
      registryActive[name] = true;
      registryIndex.push(name);
    }
  }

  function activateAddress(address addr) internal {
    if (!lookupActive[addr]) {
      lookupActive[addr] = true;
      lookupIndex.push(addr);
    }
  }
}
