// File: ../sc_datasets/DAppSCAN/consensys-0x_Protocol_v2/0x-monorepo-a05b14e4d9659be1cc495ee33fd8962ce773f87f/packages/contracts/src/1.0.0/Ownable/Ownable_v1.sol

pragma solidity ^0.4.18;

/*
 * Ownable
 *
 * Base contract with an owner.
 * Provides onlyOwner modifier, which prevents function from running if it is called by anyone other than the owner.
 */

contract Ownable_v1 {
    address public owner;

    function Ownable_v1() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
}
