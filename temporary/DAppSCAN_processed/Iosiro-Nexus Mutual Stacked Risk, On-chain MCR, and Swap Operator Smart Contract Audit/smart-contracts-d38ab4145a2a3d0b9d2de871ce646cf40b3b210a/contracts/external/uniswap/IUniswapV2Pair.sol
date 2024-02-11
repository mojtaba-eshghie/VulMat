// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/external/uniswap/IUniswapV2Pair.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IUniswapV2Pair {
  function getReserves() external view returns (uint112, uint112, uint32);
}
