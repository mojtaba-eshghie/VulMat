// File: ../sc_datasets/DAppSCAN/QuillAudits-Crazy Snake Smart Contract/CrazyToken-489ae9dab8eb5ba684fa1c7dbbd803c9db52dc9d/contracts/Migrations.sol

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
