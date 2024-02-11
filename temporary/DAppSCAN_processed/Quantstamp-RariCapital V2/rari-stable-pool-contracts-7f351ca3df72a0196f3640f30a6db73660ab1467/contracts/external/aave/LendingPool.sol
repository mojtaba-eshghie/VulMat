// File: ../sc_datasets/DAppSCAN/Quantstamp-RariCapital V2/rari-stable-pool-contracts-7f351ca3df72a0196f3640f30a6db73660ab1467/contracts/external/aave/LendingPool.sol

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.5.17;

/**
 * @title LendingPool contract
 * @notice Implements the actions of the LendingPool, and exposes accessory methods to fetch the users and reserve data
 * @author Aave
 */
contract LendingPool {
    /**
     * @dev deposits The underlying asset into the reserve. A corresponding amount of the overlying asset (aTokens)
     * is minted.
     * @param _reserve the address of the reserve
     * @param _amount the amount to be deposited
     * @param _referralCode integrators are assigned a referral code and can potentially receive rewards.
     */
    function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external payable;
}
