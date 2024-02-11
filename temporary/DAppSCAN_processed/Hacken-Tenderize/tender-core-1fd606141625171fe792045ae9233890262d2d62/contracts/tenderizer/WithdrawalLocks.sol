// File: ../sc_datasets/DAppSCAN/Hacken-Tenderize/tender-core-1fd606141625171fe792045ae9233890262d2d62/contracts/libs/MathUtils.sol

// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

library MathUtils {
    // Divisor used for representing percentages
    uint256 public constant PERC_DIVISOR = 10**21;

    /**
     * @dev Returns whether an amount is a valid percentage out of PERC_DIVISOR
     * @param _amount Amount that is supposed to be a percentage
     */
    function validPerc(uint256 _amount) internal pure returns (bool) {
        return _amount <= PERC_DIVISOR;
    }

    /**
     * @dev Compute percentage of a value with the percentage represented by a fraction
     * @param _amount Amount to take the percentage of
     * @param _fracNum Numerator of fraction representing the percentage
     * @param _fracDenom Denominator of fraction representing the percentage
     */
    function percOf(
        uint256 _amount,
        uint256 _fracNum,
        uint256 _fracDenom
    ) internal pure returns (uint256) {
        return (_amount * percPoints(_fracNum, _fracDenom)) / PERC_DIVISOR;
    }

    /**
     * @dev Compute percentage of a value with the percentage represented by a fraction over PERC_DIVISOR
     * @param _amount Amount to take the percentage of
     * @param _fracNum Numerator of fraction representing the percentage with PERC_DIVISOR as the denominator
     */
    function percOf(uint256 _amount, uint256 _fracNum) internal pure returns (uint256) {
        return (_amount * _fracNum) / PERC_DIVISOR;
    }

    /**
     * @dev Compute percentage representation of a fraction
     * @param _fracNum Numerator of fraction represeting the percentage
     * @param _fracDenom Denominator of fraction represeting the percentage
     */
    function percPoints(uint256 _fracNum, uint256 _fracDenom) internal pure returns (uint256) {
        return (_fracNum * PERC_DIVISOR) / _fracDenom;
    }

    /**
     * @notice Compares a and b and returns true if the difference between a and b
     *         is less than 1 or equal to each other.
     * @param a uint256 to compare with
     * @param b uint256 to compare with
     * @return True if the difference between a and b is less than 1 or equal,
     *         otherwise return false
     */
    function within1(uint256 a, uint256 b) internal pure returns (bool) {
        return (difference(a, b) <= 1);
    }

    /**
     * @notice Calculates absolute difference between a and b
     * @param a uint256 to compare with
     * @param b uint256 to compare with
     * @return Difference between a and b
     */
    function difference(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a > b) {
            return a - b;
        }
        return b - a;
    }
}

// File: ../sc_datasets/DAppSCAN/Hacken-Tenderize/tender-core-1fd606141625171fe792045ae9233890262d2d62/contracts/tenderizer/WithdrawalLocks.sol

// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

/**
 * @notice WithdrawalLocks are used to "proxy" user unlocks/withdrawals to the underlying contracts
 */
library WithdrawalLocks {

    struct WithdrawLock {
        uint256 amount;
        address account;
    }

    struct Locks {
        mapping(uint256 => WithdrawLock) withdrawals;
        uint256 nextWithdrawLockID;
    }

    function unlock(
        Locks storage _lock,
        address _receiver,
        uint256 _amount
    ) internal returns (uint256 withdrawalLockID) {
        withdrawalLockID = _lock.nextWithdrawLockID;
        
        _lock.nextWithdrawLockID = withdrawalLockID + 1;
        
        _lock.withdrawals[withdrawalLockID] = WithdrawLock({ amount: _amount, account: _receiver });
    }

    function withdraw(
        Locks storage _lock,
        address _account,
        uint256 _withdrawalLockID
    ) internal returns (uint256 amount) {
        WithdrawLock storage lock = _lock.withdrawals[_withdrawalLockID];
        address account = lock.account;
        amount = lock.amount;
        
        require(account == _account, "ACCOUNT_MISTMATCH");
        
        delete _lock.withdrawals[_withdrawalLockID];
    }
}
