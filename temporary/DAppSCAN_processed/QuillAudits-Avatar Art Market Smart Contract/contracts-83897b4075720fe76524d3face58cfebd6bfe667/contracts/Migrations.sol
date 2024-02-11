// File: ../sc_datasets/DAppSCAN/QuillAudits-Avatar Art Market Smart Contract/contracts-83897b4075720fe76524d3face58cfebd6bfe667/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}
