// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/keep3r/IUniswapV2SlidingOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IUniswapV2SlidingOracle {
  function current(
    address tokenIn,
    uint256 amountIn,
    address tokenOut
  ) external view returns (uint256);

  function updatePair(address pair) external returns (bool);

  function workable(address pair) external view returns (bool);

  function workForFree() external;
}
