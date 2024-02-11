// File: ../sc_datasets/DAppSCAN/Chainsecurity-Compound  cToken unredacted/compound-protocol-4a54ec5c55b66ea67d44b76f3056f0ed7229db8c/tests/Contracts/MathHelpers.sol

// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.6;

contract MathHelpers {

    /*
     * @dev Creates a number like 15e16 as a uint256 from scientific(15, 16).
     */
    function scientific(uint val, uint expTen) pure internal returns (uint) {
        return val * ( 10 ** expTen );
    }

}
