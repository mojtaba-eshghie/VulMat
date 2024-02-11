// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Generic Lender/yearnV2-generic-lender-strat-979ef2f0e5da39ca59a5907c37ba2064fcd6be82/contracts/Interfaces/Aave/IFlashLoanReceiver.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

/**
 * @title IFlashLoanReceiver interface
 * @notice Interface for the Aave fee IFlashLoanReceiver.
 * @author Aave
 * @dev implement this interface to develop a flashloan-compatible flashLoanReceiver contract
 **/
interface IFlashLoanReceiver {
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    ) external;
}
