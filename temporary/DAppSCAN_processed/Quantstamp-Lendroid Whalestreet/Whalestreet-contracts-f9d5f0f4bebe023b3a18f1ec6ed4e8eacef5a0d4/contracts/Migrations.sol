// File: ../sc_datasets/DAppSCAN/Quantstamp-Lendroid Whalestreet/Whalestreet-contracts-f9d5f0f4bebe023b3a18f1ec6ed4e8eacef5a0d4/contracts/Migrations.sol

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
