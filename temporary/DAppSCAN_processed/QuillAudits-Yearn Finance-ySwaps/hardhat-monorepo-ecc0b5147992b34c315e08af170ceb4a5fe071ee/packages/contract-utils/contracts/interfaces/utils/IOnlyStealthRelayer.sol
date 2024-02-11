// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/contract-utils/contracts/interfaces/utils/IOnlyStealthRelayer.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface IOnlyStealthRelayer {
  event StealthRelayerSet(address _stealthRelayer);

  function setStealthRelayer(address _stealthRelayer) external;
}
