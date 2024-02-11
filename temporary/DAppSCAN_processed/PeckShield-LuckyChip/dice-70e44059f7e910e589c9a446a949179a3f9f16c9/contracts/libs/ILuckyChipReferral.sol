// File: ../sc_datasets/DAppSCAN/PeckShield-LuckyChip/dice-70e44059f7e910e589c9a446a949179a3f9f16c9/contracts/libs/ILuckyChipReferral.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface ILuckyChipReferral {
    /**
     * @dev Record referral.
     */
    function recordReferral(address user, address referrer) external;

    /**
     * @dev Record referral commission.
     */
    function recordReferralCommission(address referrer, uint256 commission) external;

    /**
     * @dev Get the referrer address that referred the user.
     */
    function getReferrer(address user) external view returns (address);
}
