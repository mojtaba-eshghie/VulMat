// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/lib/VotingPowerFormula.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract VotingPowerFormula {
   function convertTokensToVotingPower(uint256 amount) external view virtual returns (uint256);
}
