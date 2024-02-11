// File: ../sc_datasets/DAppSCAN/Hacken-thrivecoin/thc-smart-contracts-sol-db78d6b4cf6dcb9e49e7a1f146851f77fa872bbf/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Migrations {
  address public owner = msg.sender;
  uint256 public last_completed_migration;

  modifier restricted() {
    require(msg.sender == owner, "This function is restricted to the contract's owner");
    _;
  }

  function setCompleted(uint256 completed) public restricted {
    last_completed_migration = completed;
  }
}
