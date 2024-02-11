// File: ../sc_datasets/DAppSCAN/Hacken-thrivecoin/thc-smart-contracts-sol-5b755d9d733e1b8df71d4d39faeb85983213c83c/contracts/Migrations.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

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
