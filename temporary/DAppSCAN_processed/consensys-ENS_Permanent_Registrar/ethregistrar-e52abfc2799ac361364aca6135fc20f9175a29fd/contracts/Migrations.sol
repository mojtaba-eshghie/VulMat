// File: ../sc_datasets/DAppSCAN/consensys-ENS_Permanent_Registrar/ethregistrar-e52abfc2799ac361364aca6135fc20f9175a29fd/contracts/Migrations.sol

pragma solidity ^0.5.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
