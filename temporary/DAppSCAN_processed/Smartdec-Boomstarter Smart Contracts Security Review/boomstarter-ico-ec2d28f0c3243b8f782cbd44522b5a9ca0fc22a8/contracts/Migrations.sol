// File: ../sc_datasets/DAppSCAN/Smartdec-Boomstarter Smart Contracts Security Review/boomstarter-ico-ec2d28f0c3243b8f782cbd44522b5a9ca0fc22a8/contracts/Migrations.sol

pragma solidity ^0.4.4;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
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
