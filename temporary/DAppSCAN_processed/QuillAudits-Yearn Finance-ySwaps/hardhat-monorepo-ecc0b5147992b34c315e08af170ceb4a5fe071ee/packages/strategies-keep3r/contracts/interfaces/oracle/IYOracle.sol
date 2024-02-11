// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/oracle/IYOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IYOracle {
  function defaultOracle() external view returns (address _defaultOracle);

  function pairOracle(address _pair) external view returns (address _oracle);

  function setPairOracle(address _pair, address _oracle) external;

  function setDefaultOracle(address _oracle) external;

  function getAmountOut(
    address _pair,
    address _tokenIn,
    uint256 _amountIn,
    address _tokenOut
  ) external view returns (uint256 _amountOut);
}
