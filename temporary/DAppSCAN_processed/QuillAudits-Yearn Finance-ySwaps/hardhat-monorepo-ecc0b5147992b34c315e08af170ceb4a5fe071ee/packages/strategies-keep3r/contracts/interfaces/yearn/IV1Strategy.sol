// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/yearn/IV1Strategy.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IV1Strategy {
  function want() external view returns (address);

  function deposit() external;

  function withdraw(address) external;

  function withdraw(uint256) external;

  function skim() external;

  function withdrawAll() external returns (uint256);

  function balanceOf() external view returns (uint256);

  function keeper() external view returns (address);

  function harvest() external;

  // only for crv
  function gauge() external pure returns (address);

  function voter() external pure returns (address);

  function setBorrowCollateralizationRatio(uint256 _c) external;
}
