// File: ../sc_datasets/DAppSCAN/Smartdec-SONM Smart Contracts Security Analysis/core-8b349d25214c6c600f4724e3e9ed3dbc57f9ae63/blockchain/source/contracts/Migrations.sol

pragma solidity ^0.4.23;

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

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
