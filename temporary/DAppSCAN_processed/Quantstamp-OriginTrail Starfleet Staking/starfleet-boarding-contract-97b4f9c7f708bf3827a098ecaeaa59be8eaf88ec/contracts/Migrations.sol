// File: ../sc_datasets/DAppSCAN/Quantstamp-OriginTrail Starfleet Staking/starfleet-boarding-contract-97b4f9c7f708bf3827a098ecaeaa59be8eaf88ec/contracts/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <=0.8.0;

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
