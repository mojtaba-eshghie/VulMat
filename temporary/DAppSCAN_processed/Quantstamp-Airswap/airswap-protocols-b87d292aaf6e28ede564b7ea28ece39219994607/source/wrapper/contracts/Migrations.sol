// File: ../sc_datasets/DAppSCAN/Quantstamp-Airswap/airswap-protocols-b87d292aaf6e28ede564b7ea28ece39219994607/source/wrapper/contracts/Migrations.sol

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

  function setCompleted(uint completed) external restricted {
    lastCompletedMigration = completed;
  }

  function upgrade(address newAddress) external restricted {
    Migrations upgraded = Migrations(newAddress);
    upgraded.setCompleted(lastCompletedMigration);
  }
}
