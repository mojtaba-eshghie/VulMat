// File: ../sc_datasets/DAppSCAN/PeckShield-IronLend/iron-lend-f9a669850885895215579e3c2ae8d7124f0ef5c8/src/0.8.4/libs/Babylonian.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

// computes square roots using the babylonian method
// https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method
library Babylonian {
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0
    }
}
