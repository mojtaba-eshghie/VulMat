// File: ../sc_datasets/DAppSCAN/SlowMist-ForTube2.0 Smart Contract Security Audit Report/bond-854527d0ea7ad2ddd3504b4d4ae3fcb57cb6445d/contracts/Migrations.sol

pragma solidity ^0.6.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}
