// File: ../sc_datasets/DAppSCAN/PeckShield-OpenLeverage1.0/openleverage-contracts-e31d971bcb38ec8737cf1942b8fdf6a9452e5834/contracts/Migrations.sol

// SPDX-License-Identifier: BUSL-1.1
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
