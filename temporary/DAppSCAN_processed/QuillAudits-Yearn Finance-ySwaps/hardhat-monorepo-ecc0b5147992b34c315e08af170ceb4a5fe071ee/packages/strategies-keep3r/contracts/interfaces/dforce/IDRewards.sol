// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/dforce/IDRewards.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IDRewards {
  function earned(address account) external view returns (uint256);
}
