// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-LiquityProtocolandStabilityPoolFinalReport/dev-8cec3fda04b8c71994dc14858386bf6a161164fc/packages/contracts/contracts/Migrations.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
