// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/yswaps/contracts/interfaces/yearn/IVault.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface IVault {
  function withdraw(
    uint256,
    address,
    uint256
  ) external returns (uint256);
}
