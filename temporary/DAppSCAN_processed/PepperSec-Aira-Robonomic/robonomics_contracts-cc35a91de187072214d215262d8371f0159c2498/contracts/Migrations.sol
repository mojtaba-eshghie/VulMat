// File: ../sc_datasets/DAppSCAN/PepperSec-Aira-Robonomic/robonomics_contracts-cc35a91de187072214d215262d8371f0159c2498/contracts/Migrations.sol

pragma solidity ^0.4.24;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() public {
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
