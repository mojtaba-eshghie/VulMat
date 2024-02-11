// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/keep3r/IKeep3rV2OracleFactory.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IKeep3rV2OracleFactory {
  function current(
    address pair,
    address tokenIn,
    uint256 amountIn,
    address tokenOut
  ) external view returns (uint256 amountOut, uint256 lastUpdatedAgo);
}
