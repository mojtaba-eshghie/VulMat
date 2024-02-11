// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Lido Protocol/lido-dao-801d3e854efb33ff33a59fe51187e187047a6be2/contracts/0.4.24/interfaces/ILidoMevTxFeeVault.sol

// SPDX-FileCopyrightText: 2021 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;


interface ILidoMevTxFeeVault {

    /**
    * @notice Withdraw all accumulated rewards to Lido contract
    * @return amount uint256 of funds received as MEV and transaction fees in wei
    */
    function withdrawRewards() external returns (uint256 amount);
}
