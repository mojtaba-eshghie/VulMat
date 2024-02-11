// File: ../sc_datasets/DAppSCAN/Quantstamp-Stormx Token/stormx-token-0d1a63bb1cbb366f9bd49c242770f7ae1af7f055/contracts/Migrations.sol

pragma solidity 0.5.16;


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
