// File: ../sc_datasets/DAppSCAN/Quantstamp-SKALE Allocator/skale-allocator-b427bb2eab1b137cff2f7d216248079a40d3e7b2/contracts/thirdparty/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

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
