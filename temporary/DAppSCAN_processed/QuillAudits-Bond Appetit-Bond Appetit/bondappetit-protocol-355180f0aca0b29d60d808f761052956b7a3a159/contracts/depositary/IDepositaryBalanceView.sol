// File: ../sc_datasets/DAppSCAN/QuillAudits-Bond Appetit-Bond Appetit/bondappetit-protocol-355180f0aca0b29d60d808f761052956b7a3a159/contracts/depositary/IDepositaryBalanceView.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/**
 * @title The Depositary Balance interface.
 */
interface IDepositaryBalanceView {
    /**
     * @notice Get decimals balance.
     * @return Decimals balance.
     */
    function decimals() external view returns(uint256);

    /**
     * @notice Get balance of depositary.
     * @return Balance of depositary.
     */
    function balance() external view returns(uint256);
}
