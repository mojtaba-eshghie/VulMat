// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-Stakefish_BatchDeposit/eth2-batch-deposit-a4912b2d839305da8447b7cec6b2f09238b90e37/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

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
