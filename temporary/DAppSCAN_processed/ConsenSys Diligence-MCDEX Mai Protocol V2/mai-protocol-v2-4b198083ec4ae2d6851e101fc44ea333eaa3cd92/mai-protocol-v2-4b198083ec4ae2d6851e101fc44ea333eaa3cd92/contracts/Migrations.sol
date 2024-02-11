// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-MCDEX Mai Protocol V2/mai-protocol-v2-4b198083ec4ae2d6851e101fc44ea333eaa3cd92/mai-protocol-v2-4b198083ec4ae2d6851e101fc44ea333eaa3cd92/contracts/Migrations.sol

pragma solidity ^0.5.2;

contract Migrations {
    address public owner;
    uint256 public last_completed_migration;

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
