// File: ../sc_datasets/DAppSCAN/consensys-Amp/flexa-collateral-manager-4203e96d1138632a991d072d0c232fd8ba69c9e1/contracts/Migrations.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;


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
