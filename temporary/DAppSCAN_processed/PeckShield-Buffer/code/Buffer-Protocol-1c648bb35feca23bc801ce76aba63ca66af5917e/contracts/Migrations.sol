// File: ../sc_datasets/DAppSCAN/PeckShield-Buffer/code/Buffer-Protocol-1c648bb35feca23bc801ce76aba63ca66af5917e/contracts/Migrations.sol

pragma solidity ^0.8.0;

/**
 * SPDX-License-Identifier: no-license
 */

contract Migrations {
    address public owner;
    uint256 public last_completed_migration;

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
