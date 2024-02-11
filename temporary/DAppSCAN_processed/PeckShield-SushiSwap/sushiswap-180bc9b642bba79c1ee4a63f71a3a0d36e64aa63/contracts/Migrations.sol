// File: ../sc_datasets/DAppSCAN/PeckShield-SushiSwap/sushiswap-180bc9b642bba79c1ee4a63f71a3a0d36e64aa63/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
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
