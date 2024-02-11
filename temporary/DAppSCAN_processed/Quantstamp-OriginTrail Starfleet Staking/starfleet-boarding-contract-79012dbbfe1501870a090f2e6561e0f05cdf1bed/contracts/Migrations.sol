// File: ../sc_datasets/DAppSCAN/Quantstamp-OriginTrail Starfleet Staking/starfleet-boarding-contract-79012dbbfe1501870a090f2e6561e0f05cdf1bed/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.10;

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
