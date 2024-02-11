// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-ENS Permanent Registrar/root-646a10cba68f38df4d72f4823be010724ec6829a/contracts/Migrations.sol

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
