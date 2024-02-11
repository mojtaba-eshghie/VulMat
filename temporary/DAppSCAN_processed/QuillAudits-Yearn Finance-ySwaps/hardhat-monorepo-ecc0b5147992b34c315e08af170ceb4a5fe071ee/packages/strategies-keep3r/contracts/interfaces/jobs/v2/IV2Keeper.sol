// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/jobs/v2/IV2Keeper.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8;

interface IV2Keeper {
  // Getters
  function jobs() external view returns (address[] memory);

  event JobAdded(address _job);
  event JobRemoved(address _job);

  // Setters
  function addJobs(address[] calldata _jobs) external;

  function addJob(address _job) external;

  function removeJob(address _job) external;

  // Jobs actions
  function tend(address _strategy) external;

  function harvest(address _strategy) external;
}
