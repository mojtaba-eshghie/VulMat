// File: ../sc_datasets/DAppSCAN/QuillAudits-Bond Appetit-Bond Appetit/bondappetit-protocol-88680691fe8d872c5fc26e9500d19cf7caaa9861/contracts/depositary/IDepositaryBalanceView.sol

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
