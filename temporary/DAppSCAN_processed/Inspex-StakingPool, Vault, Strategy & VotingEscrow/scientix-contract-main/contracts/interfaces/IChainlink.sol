// File: ../sc_datasets/DAppSCAN/Inspex-StakingPool, Vault, Strategy & VotingEscrow/scientix-contract-main/contracts/interfaces/IChainlink.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

interface IChainlink {
  function latestAnswer() external view returns (int256);
}
