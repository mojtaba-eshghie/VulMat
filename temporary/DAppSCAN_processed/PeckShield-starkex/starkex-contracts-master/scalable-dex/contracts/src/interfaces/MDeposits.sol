// File: ../sc_datasets/DAppSCAN/PeckShield-starkex/starkex-contracts-master/scalable-dex/contracts/src/interfaces/MDeposits.sol

// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

abstract contract MDeposits {
    function depositERC20(
        // NOLINT external-function.
        uint256 starkKey,
        uint256 assetType,
        uint256 vaultId,
        uint256 quantizedAmount
    ) public virtual;

    function depositEth(
        // NOLINT external-function.
        uint256 starkKey,
        uint256 assetType,
        uint256 vaultId
    ) public payable virtual;
}
