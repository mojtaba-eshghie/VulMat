// File: ../sc_datasets/DAppSCAN/Byterocket-RealityCards v1[05.19.2020]/RealityCards-Contracts-aad8ea70696d848e2fcb55b7932c7ba37b8f239e/contracts/Migrations.sol

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
