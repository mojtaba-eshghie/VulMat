// File: ../sc_datasets/DAppSCAN/PeckShield-LuckyChip/staking-23e5db6078aa12754ae69048c7754c7f1e90b375/contracts/libs/Migrations.sol

pragma solidity >=0.4.25 <0.7.0;

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
}
