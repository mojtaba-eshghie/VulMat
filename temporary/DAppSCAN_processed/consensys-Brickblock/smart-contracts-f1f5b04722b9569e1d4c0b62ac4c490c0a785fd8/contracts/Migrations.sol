// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/Migrations.sol

pragma solidity 0.4.23;


contract Migrations {
  address public owner;
  uint public lastCompletedMigration;

  modifier restricted() {
    if (msg.sender == owner)
      _;
  }

  constructor()
    public
  {
    owner = msg.sender;
  }

  function setCompleted(uint completed)
    restricted
    public
  {
    lastCompletedMigration = completed;
  }

  function upgrade(address newAddress)
    restricted
    public
  {
    Migrations upgraded = Migrations(newAddress);
    upgraded.setCompleted(lastCompletedMigration);
  }
}
