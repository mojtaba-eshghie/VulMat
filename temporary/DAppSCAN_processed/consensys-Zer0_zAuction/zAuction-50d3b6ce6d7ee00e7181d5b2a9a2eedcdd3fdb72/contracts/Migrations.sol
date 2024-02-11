// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zAuction/zAuction-50d3b6ce6d7ee00e7181d5b2a9a2eedcdd3fdb72/contracts/Migrations.sol

pragma solidity ^0.8.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
