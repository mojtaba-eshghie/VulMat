// File: ../sc_datasets/DAppSCAN/Quantstamp-Compound Protocol/compound-protocol-ccc7d510553cea26af89abd01274d583acae2ff3/tests/Contracts/MathHelpers.sol

pragma solidity ^0.5.16;

contract MathHelpers {

    /*
     * @dev Creates a number like 15e16 as a uint256 from scientific(15, 16).
     */
    function scientific(uint val, uint expTen) pure internal returns (uint) {
        return val * ( 10 ** expTen );
    }

}
