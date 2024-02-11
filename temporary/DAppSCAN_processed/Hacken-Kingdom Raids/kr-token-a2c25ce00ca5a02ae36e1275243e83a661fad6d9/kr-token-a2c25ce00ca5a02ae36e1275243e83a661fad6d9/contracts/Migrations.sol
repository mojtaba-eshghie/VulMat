// File: ../sc_datasets/DAppSCAN/Hacken-Kingdom Raids/kr-token-a2c25ce00ca5a02ae36e1275243e83a661fad6d9/kr-token-a2c25ce00ca5a02ae36e1275243e83a661fad6d9/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22;

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
