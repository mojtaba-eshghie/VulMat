// File: ../sc_datasets/DAppSCAN/consensys-TCR/tcr-b206561249ed1779f10aa4ba390ffee676148134/contracts/Migrations.sol

pragma solidity ^0.4.18;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
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
