// File: ../sc_datasets/DAppSCAN/openzeppelin-OpenBazaar’s_Escrow/smart-contracts-c4f02cdd41cb85d28bba637a01f20a8ee8bb04bd/contracts/Migrations.sol

pragma solidity 0.4.24;
pragma experimental "v0.5.0";


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
