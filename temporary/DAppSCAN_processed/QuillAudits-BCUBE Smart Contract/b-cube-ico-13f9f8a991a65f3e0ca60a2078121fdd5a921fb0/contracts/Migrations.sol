// File: ../sc_datasets/DAppSCAN/QuillAudits-BCUBE Smart Contract/b-cube-ico-13f9f8a991a65f3e0ca60a2078121fdd5a921fb0/contracts/Migrations.sol

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
