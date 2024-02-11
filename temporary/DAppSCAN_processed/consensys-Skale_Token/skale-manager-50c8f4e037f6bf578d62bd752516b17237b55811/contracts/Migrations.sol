// File: ../sc_datasets/DAppSCAN/consensys-Skale_Token/skale-manager-50c8f4e037f6bf578d62bd752516b17237b55811/contracts/Migrations.sol

pragma solidity ^0.5.3;


contract Migrations {
    address public owner;
    uint public last_completed_migration;

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function setCompleted(uint completed) external restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) external restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
