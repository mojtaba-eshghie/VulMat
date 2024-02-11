// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/Migrations.sol

pragma solidity 0.5.13;

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
