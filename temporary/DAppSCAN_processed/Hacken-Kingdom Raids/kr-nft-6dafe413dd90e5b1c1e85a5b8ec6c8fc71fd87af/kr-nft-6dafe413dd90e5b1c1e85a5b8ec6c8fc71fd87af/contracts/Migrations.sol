// File: ../sc_datasets/DAppSCAN/Hacken-Kingdom Raids/kr-nft-6dafe413dd90e5b1c1e85a5b8ec6c8fc71fd87af/kr-nft-6dafe413dd90e5b1c1e85a5b8ec6c8fc71fd87af/contracts/Migrations.sol

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
