// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-60efdf64f2198050f7e6fcec57548d40e4f8598f/contracts/external/uniswap/IUniswapV2Pair.sol

// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity ^0.8.0;

interface IUniswapV2Pair {
  function getReserves() external view returns (uint112, uint112, uint32);
}
