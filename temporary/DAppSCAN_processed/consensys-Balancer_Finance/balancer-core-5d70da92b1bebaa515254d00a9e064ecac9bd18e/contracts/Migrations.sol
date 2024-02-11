// File: ../sc_datasets/DAppSCAN/consensys-Balancer_Finance/balancer-core-5d70da92b1bebaa515254d00a9e064ecac9bd18e/contracts/Migrations.sol

pragma solidity 0.5.12;

contract Migrations {
    address public owner;
    uint public lastCompletedMigration;

    constructor() public {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    function setCompleted(uint completed) external restricted {
        lastCompletedMigration = completed;
    }

    function upgrade(address new_address) external restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(lastCompletedMigration);
    }
}
