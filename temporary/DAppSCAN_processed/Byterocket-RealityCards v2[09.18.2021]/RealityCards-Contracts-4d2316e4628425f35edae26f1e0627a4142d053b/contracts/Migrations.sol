// File: ../sc_datasets/DAppSCAN/Byterocket-RealityCards v2[09.18.2021]/RealityCards-Contracts-4d2316e4628425f35edae26f1e0627a4142d053b/contracts/Migrations.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract Migrations {
    address public owner;
    uint256 public last_completed_migration;

    constructor() {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
