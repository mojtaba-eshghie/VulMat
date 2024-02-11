// File: ../sc_datasets/DAppSCAN/consensys-ENS_Permanent_Registrar/root-c82010e34828d72319efb66aae921609d3c7a704/contracts/Ownable.sol

pragma solidity ^0.5.0;

contract Ownable {

    address public owner;

    modifier onlyOwner {
        require(isOwner(msg.sender));
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function isOwner(address addr) public view returns (bool) {
        return owner == addr;
    }
}
