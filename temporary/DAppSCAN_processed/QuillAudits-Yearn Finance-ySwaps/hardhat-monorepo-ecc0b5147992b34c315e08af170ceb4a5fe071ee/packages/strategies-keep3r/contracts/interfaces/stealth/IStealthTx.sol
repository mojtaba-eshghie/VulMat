// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/stealth/IStealthTx.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IStealthTx {
  event StealthVaultSet(address _stealthVault);
  event PenaltySet(uint256 _penalty);
  event MigratedStealthVault(address _migratedTo);

  function stealthVault() external view returns (address);

  function penalty() external view returns (uint256);

  function setStealthVault(address _stealthVault) external;

  function setPenalty(uint256 _penalty) external;
}
