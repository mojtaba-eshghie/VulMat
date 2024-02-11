// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/libraries/Math.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

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
