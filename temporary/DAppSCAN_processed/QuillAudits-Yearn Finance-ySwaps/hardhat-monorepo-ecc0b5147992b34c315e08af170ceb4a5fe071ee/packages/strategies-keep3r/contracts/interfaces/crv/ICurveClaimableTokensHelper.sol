// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/crv/ICurveClaimableTokensHelper.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface ICurveClaimableTokensHelper {
  function claimable_tokens(address _gauge, address _voter) external view returns (uint256 _claimableTokens);
}
