// File: ../sc_datasets/DAppSCAN/Blockchain Labs NZ-Ecomi/tge-contract-audit-17b96ff760471c174d8edbeacc6b8cd2cf2c6b82/contracts/Migrations.sol

// SWC-Outdated Compiler Version: L2
pragma solidity ^0.4.18;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
