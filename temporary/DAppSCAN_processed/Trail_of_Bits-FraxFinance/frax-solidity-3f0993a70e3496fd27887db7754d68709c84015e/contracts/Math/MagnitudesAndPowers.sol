// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Math/MagnitudesAndPowers.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

// https://ethereum.stackexchange.com/a/69590
library MagnitudesAndPowers {
    
    function magnitude (uint x) public pure returns (uint) {
        require (x > 0);

        uint a = 0;
        uint b = 77;

        while (b > a) {
            uint m = a + b + 1 >> 1;
            if (x >= pow10 (m)) a = m;
            else b = m - 1;
        }

        return a;
    }

    function pow10 (uint x) private pure returns (uint) {
        uint result = 1;
        uint y = 10;
        while (x > 0) {
            if (x % 2 == 1) {
                result *= y;
                x -= 1;
            } else {
                y *= y;
                x >>= 1;
            }
        }
        return result;
    }

}
