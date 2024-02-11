// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/jobs/ICrvStrategyKeep3rJobV2.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface ICrvStrategyKeep3rJobV2 {
  function v2Keeper() external view returns (address _v2Keeper);

  function strategyIsV1(address _strategy) external view returns (bool);

  function setV2Keep3r(address _v2Keeper) external;

  function forceWorkUnsafe(address _strategy) external;
}
