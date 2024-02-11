// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-MapleFinance/debt-locker-05b4f2fe119e2ddf3dc0e441055c602f748e7d52/contracts/DebtLockerStorage.sol

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

/// @title DebtLockerStorage maps the storage layout of a DebtLocker.
contract DebtLockerStorage {

    address internal _loan;
    address internal _liquidator;
    address internal _pool;

    uint256 internal _allowedSlippage;
    uint256 internal _amountRecovered;
    uint256 internal _fundsToCapture;
    uint256 internal _minRatio;
    uint256 internal _principalRemainingAtLastClaim;

    bool internal _repossessed;
}
