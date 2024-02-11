// File: ../sc_datasets/DAppSCAN/Smartdec-РumaPay Smart Contracts Security Analysis/smart-contracts-5eb99b1a94d9e5d98873fb4338b97943b9821569/contracts/Migrations.sol

pragma solidity 0.5.8;

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
