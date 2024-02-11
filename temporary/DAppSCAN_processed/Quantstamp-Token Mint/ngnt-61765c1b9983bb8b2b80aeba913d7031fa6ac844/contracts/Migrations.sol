// File: ../sc_datasets/DAppSCAN/Quantstamp-Token Mint/ngnt-61765c1b9983bb8b2b80aeba913d7031fa6ac844/contracts/Migrations.sol

pragma solidity 0.5.5;

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
