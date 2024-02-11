// File: ../sc_datasets/DAppSCAN/Hacken-Kingdom Raids/kr-ido-contract-b8e0b81319209fc0e3144d336d3a9e0bcc808b62/kr-ido-contract-b8e0b81319209fc0e3144d336d3a9e0bcc808b62/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

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
