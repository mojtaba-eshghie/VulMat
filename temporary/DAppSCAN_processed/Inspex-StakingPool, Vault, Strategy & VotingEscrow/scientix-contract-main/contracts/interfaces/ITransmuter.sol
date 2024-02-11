// File: ../sc_datasets/DAppSCAN/Inspex-StakingPool, Vault, Strategy & VotingEscrow/scientix-contract-main/contracts/interfaces/ITransmuter.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

interface ITransmuter  {
  function distribute (address origin, uint256 amount) external;
}
