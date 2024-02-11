// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/crv/ICrvClaimable.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface ICrvClaimable {
  function claimable_tokens(address _address) external returns (uint256 _amount);
}
