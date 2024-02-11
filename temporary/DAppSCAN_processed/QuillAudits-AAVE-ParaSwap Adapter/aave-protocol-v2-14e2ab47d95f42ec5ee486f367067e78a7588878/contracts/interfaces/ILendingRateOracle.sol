// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-ParaSwap Adapter/aave-protocol-v2-14e2ab47d95f42ec5ee486f367067e78a7588878/contracts/interfaces/ILendingRateOracle.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title ILendingRateOracle interface
 * @notice Interface for the Aave borrow rate oracle. Provides the average market borrow rate to be used as a base for the stable borrow rate calculations
 **/

interface ILendingRateOracle {
  /**
    @dev returns the market borrow rate in ray
    **/
  function getMarketBorrowRate(address asset) external view returns (uint256);

  /**
    @dev sets the market borrow rate. Rate value must be in ray
    **/
  function setMarketBorrowRate(address asset, uint256 rate) external;
}
