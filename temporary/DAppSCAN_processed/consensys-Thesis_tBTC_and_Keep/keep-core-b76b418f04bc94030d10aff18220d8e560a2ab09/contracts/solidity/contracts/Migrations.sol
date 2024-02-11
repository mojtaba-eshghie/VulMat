// File: ../sc_datasets/DAppSCAN/consensys-Thesis_tBTC_and_Keep/keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/Migrations.sol

pragma solidity ^0.5.4;

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
