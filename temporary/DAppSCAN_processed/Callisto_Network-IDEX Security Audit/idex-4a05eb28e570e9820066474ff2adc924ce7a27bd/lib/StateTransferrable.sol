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
