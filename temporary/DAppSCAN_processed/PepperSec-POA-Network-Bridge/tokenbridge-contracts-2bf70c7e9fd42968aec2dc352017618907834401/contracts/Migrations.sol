// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/contracts/Migrations.sol

pragma solidity 0.4.24;

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
