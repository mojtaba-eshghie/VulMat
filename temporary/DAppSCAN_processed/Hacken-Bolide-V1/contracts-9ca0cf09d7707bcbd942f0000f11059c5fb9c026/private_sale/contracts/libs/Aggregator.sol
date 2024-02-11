// File: ../sc_datasets/DAppSCAN/Hacken-Bolide-V1/contracts-9ca0cf09d7707bcbd942f0000f11059c5fb9c026/private_sale/contracts/libs/Aggregator.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

contract Aggregator {
    function decimals() external view returns (uint8) {
        return 8;
    }

    function latestAnswer() external view returns (int256 answer) {
        return 100000000;
    }
}
