// File: ../sc_datasets/DAppSCAN/Hacken-Bolide-V2/contracts-9ca0cf09d7707bcbd942f0000f11059c5fb9c026/farming/contracts/libs/Migrations.sol

// SWC-Floating Pragma: L2
pragma solidity ^0.8.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}
