// File: ../sc_datasets/DAppSCAN/consensys-ENS_Permanent_Registrar/root-c82010e34828d72319efb66aae921609d3c7a704/contracts/Migrations.sol

pragma solidity ^0.5.0;

contract Migrations {

    address public owner;
    uint public last_completed_migration;

    modifier restricted() {
        if (msg.sender == owner)
            _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address newAddress) public restricted {
        Migrations upgraded = Migrations(newAddress);
        upgraded.setCompleted(last_completed_migration);
    }
}
