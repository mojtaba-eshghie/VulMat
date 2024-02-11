// File: ../sc_datasets/DAppSCAN/QuillAudits-AliumSwap Smart Contract/alium-swap-periphery-6aff4c5ad4695b77358eae0627c98d72621256bc/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
// SWC-Floating Pragma: L3
pragma solidity >=0.4.25 <0.7.0;

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
