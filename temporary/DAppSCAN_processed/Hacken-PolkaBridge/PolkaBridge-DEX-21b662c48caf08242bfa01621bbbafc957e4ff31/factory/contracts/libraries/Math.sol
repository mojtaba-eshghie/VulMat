// File: ../sc_datasets/DAppSCAN/Hacken-PolkaBridge/PolkaBridge-DEX-21b662c48caf08242bfa01621bbbafc957e4ff31/factory/contracts/libraries/Math.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// a library for performing various math operations

library Math {
    function min(uint x, uint y) internal pure returns (uint z) {
        z = x < y ? x : y;
    }

    // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}
