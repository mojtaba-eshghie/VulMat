// File: ../sc_datasets/DAppSCAN/Hacken-Bolide-V1/contracts-9ca0cf09d7707bcbd942f0000f11059c5fb9c026/vesting/contracts/libs/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Migrations {
    address public owner = msg.sender;

    // A function with the signature `last_completed_migration()`, returning a uint, is required.
    uint public last_completed_migration;

    modifier restricted() {
        require(msg.sender == owner, "This function is restricted to the contract's owner");
        _;
    }

    // A function with the signature `setCompleted(uint)` is required.
    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }
}
