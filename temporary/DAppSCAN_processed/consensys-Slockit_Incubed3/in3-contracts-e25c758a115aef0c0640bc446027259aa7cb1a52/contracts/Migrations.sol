// File: ../sc_datasets/DAppSCAN/consensys-Slockit_Incubed3/in3-contracts-e25c758a115aef0c0640bc446027259aa7cb1a52/contracts/Migrations.sol

pragma solidity 0.5.10;


contract Migrations {
    address public owner;
    uint public last_completed_migration;

    constructor() public {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) {
            _;
        }
    }

    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
