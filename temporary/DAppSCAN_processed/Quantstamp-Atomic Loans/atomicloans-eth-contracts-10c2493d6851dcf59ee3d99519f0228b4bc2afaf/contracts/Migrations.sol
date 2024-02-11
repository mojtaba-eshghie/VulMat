// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/Migrations.sol

pragma solidity ^0.5.10;

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
