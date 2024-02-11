// File: ../sc_datasets/DAppSCAN/Quantstamp-Airswap/airswap-protocols-b87d292aaf6e28ede564b7ea28ece39219994607/source/swap/contracts/Migrations.sol

pragma solidity >=0.4.21 <0.6.0;

contract Migrations {
  address public owner;
  uint public lastCompletedMigration;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed) public restricted {
    lastCompletedMigration = completed;
  }

  function upgrade(address newAddress) public restricted {
    Migrations upgraded = Migrations(newAddress);
    upgraded.setCompleted(lastCompletedMigration);
  }
}
