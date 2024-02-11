// File: ../sc_datasets/DAppSCAN/consensys-Skyweaver/Skyweaver-contracts-bde0c184db6168bf86656a48b12d5747950b54d9/contracts/migrations/Migrations.sol

pragma solidity ^0.5.16;


contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner)
      _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
