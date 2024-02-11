// File: ../sc_datasets/DAppSCAN/Quantstamp-SuperRare Token/rarest-token-8c5abd3c3273de70520d7b519d16893f431830f9/contracts/Migrations.sol

// contracts/SuperRareToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract Migrations {
    address public owner;
    uint256 public lastCompletedMigration;

    constructor() {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) {
            _;
        }
    }

    function setCompleted(uint256 _completed) public restricted {
        lastCompletedMigration = _completed;
    }

    function upgrade(address _newAddress) public restricted {
        Migrations upgraded = Migrations(_newAddress);
        upgraded.setCompleted(lastCompletedMigration);
    }
}
