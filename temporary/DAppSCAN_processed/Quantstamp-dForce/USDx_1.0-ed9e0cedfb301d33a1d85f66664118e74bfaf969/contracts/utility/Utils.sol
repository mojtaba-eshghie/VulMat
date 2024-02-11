// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/utility/Utils.sol

pragma solidity ^0.5.2;

/*
    Utilities & Common Modifiers
*/
contract Utils {
    modifier validAddress(address _address) {
        require(_address != address(0), "ValidAddress: address invalid.");
        _;
    }
}
