// File: ../sc_datasets/DAppSCAN/QuillAudits-Dfyn Smart Contract/dual-farm-f44a4dcbeb41f38a9c02cb877a8c95b92685f972/contracts/Migration.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

contract Migrations {
    address public owner;
    uint256 public last_completed_migration;

    constructor() public {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }
}
