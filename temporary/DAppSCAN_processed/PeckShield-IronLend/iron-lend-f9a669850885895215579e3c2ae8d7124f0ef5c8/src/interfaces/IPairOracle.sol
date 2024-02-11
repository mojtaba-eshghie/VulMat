// File: ../sc_datasets/DAppSCAN/PeckShield-IronLend/iron-lend-f9a669850885895215579e3c2ae8d7124f0ef5c8/src/interfaces/IPairOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;
pragma experimental ABIEncoderV2;

interface IPairOracle {
    function consult(uint256 amountIn) external view returns (uint256 amountOut);
}
