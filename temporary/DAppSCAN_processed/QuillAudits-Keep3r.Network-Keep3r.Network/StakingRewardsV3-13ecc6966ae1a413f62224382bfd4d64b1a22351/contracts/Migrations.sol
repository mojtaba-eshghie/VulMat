// File: ../sc_datasets/DAppSCAN/QuillAudits-Keep3r.Network-Keep3r.Network/StakingRewardsV3-13ecc6966ae1a413f62224382bfd4d64b1a22351/contracts/Migrations.sol

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
