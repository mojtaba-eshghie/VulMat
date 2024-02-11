// File: ../sc_datasets/DAppSCAN/openzeppelin-COSMOS_Fundraiser/fundraiser-lib-693cf3f32e9fd679216372876dda86fa57a3277e/src/truffle/contracts/Migrations.sol

pragma solidity ^0.4.4;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() {
    owner = msg.sender;
  }

  function setCompleted(uint completed) restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
