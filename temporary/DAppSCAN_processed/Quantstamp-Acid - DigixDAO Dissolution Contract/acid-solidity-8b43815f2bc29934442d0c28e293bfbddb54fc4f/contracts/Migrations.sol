// File: ../sc_datasets/DAppSCAN/Quantstamp-Acid - DigixDAO Dissolution Contract/acid-solidity-8b43815f2bc29934442d0c28e293bfbddb54fc4f/contracts/Migrations.sol

pragma solidity 0.5.16;

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
