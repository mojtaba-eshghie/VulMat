// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Yoracle.Link/yoracle.link-faf1309cbe7a05f70b338351315039eb8e5b9c09/contracts/Migrations.sol

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
