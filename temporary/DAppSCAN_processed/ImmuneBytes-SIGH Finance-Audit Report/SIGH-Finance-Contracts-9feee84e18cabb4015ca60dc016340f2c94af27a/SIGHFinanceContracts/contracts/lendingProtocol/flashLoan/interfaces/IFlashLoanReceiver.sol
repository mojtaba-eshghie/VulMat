// File: ../sc_datasets/DAppSCAN/ImmuneBytes-SIGH Finance-Audit Report/SIGH-Finance-Contracts-9feee84e18cabb4015ca60dc016340f2c94af27a/SIGHFinanceContracts/contracts/lendingProtocol/flashLoan/interfaces/IFlashLoanReceiver.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.7.0;

/**
 * @title IFlashLoanReceiver interface
 * @notice Interface for the Aave fee IFlashLoanReceiver.
 * @author Aave
 * @dev implement this interface to develop a flashloan-compatible flashLoanReceiver contract
 **/
interface IFlashLoanReceiver {

  function executeOperation(address _instrument, uint256 _amount, uint256 _fee, bytes calldata _params) external;

}
