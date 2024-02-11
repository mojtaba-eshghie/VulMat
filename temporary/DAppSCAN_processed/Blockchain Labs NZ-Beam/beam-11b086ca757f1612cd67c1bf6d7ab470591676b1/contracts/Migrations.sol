// File: ../sc_datasets/DAppSCAN/Blockchain Labs NZ-Beam/beam-11b086ca757f1612cd67c1bf6d7ab470591676b1/contracts/Migrations.sol

pragma solidity 0.4.24;


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

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
