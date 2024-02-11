// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/oracle/IOracleBondedKeeper.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IOracleBondedKeeper {
  // Getters
  function keep3r() external view returns (address _keep3r);

  function keep3rV1Oracle() external view returns (address _keep3rV1Oracle);

  function jobs() external view returns (address[] memory);

  event JobAdded(address _job);
  event JobRemoved(address _job);

  // Setters
  function addJobs(address[] calldata _jobs) external;

  function addJob(address _job) external;

  function removeJob(address _job) external;

  // Jobs actions
  function workable(address _pair) external view returns (bool);

  function updatePair(address _pair) external returns (bool);

  // Governor Keeper Bond
  function bond(address bonding, uint256 amount) external;

  function activate(address bonding) external;

  function unbond(address bonding, uint256 amount) external;

  function withdraw(address bonding) external;
}
