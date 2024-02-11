// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/contract-utils/contracts/interfaces/utils/IMachinery.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface IMachinery {
  // View helpers
  function mechanicsRegistry() external view returns (address _mechanicsRegistry);

  function isMechanic(address mechanic) external view returns (bool _isMechanic);

  // Setters
  function setMechanicsRegistry(address _mechanicsRegistry) external;
}
