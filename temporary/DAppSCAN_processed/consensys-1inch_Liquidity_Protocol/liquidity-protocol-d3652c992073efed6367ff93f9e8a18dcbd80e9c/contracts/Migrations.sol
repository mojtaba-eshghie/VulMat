// File: ../sc_datasets/DAppSCAN/consensys-1inch_Liquidity_Protocol/liquidity-protocol-d3652c992073efed6367ff93f9e8a18dcbd80e9c/contracts/Migrations.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


contract Migrations {
    address public owner;
    uint public lastCompletedMigration;

    modifier restricted() {
        if (msg.sender == owner) {
            _;
        }
    }

    constructor() public {
        owner = msg.sender;
    }

    function setCompleted(uint completed) public restricted {
        lastCompletedMigration = completed;
    }

    function upgrade(address newAddress) public restricted {
        Migrations upgraded = Migrations(newAddress);
        upgraded.setCompleted(lastCompletedMigration);
    }
}
