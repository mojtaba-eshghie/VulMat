// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-BalancerCore/balancer-core-942a51e202cc5bf9158bad77162bc72aa0a8afaf/contracts/Migrations.sol

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
