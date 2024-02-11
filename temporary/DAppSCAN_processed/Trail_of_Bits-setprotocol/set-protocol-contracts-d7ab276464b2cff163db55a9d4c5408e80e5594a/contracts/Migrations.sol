// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-d7ab276464b2cff163db55a9d4c5408e80e5594a/contracts/Migrations.sol

pragma solidity 0.4.25;


contract Migrations {
  address public owner;
  uint256 public lastCompletedMigration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor() public {
    owner = msg.sender;
  }

  function setCompleted(uint256 completed) external restricted {
    lastCompletedMigration = completed;
  }

  function upgrade(address newAddress) external restricted {
    Migrations upgraded = Migrations(newAddress);
    upgraded.setCompleted(lastCompletedMigration);
  }
}
