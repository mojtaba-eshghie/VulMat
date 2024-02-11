// File: ../sc_datasets/DAppSCAN/Coinfabrik-Casper CST Token Sale Security Audit/presale-master/contracts/Owned.sol

pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// Owned contract
// ----------------------------------------------------------------------------
contract Owned {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}
