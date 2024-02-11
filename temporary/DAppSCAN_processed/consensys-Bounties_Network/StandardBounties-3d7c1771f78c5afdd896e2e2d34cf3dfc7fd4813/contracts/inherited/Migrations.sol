// File: ../sc_datasets/DAppSCAN/consensys-Bounties_Network/StandardBounties-3d7c1771f78c5afdd896e2e2d34cf3dfc7fd4813/contracts/inherited/Migrations.sol

pragma solidity 0.5.0;

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
