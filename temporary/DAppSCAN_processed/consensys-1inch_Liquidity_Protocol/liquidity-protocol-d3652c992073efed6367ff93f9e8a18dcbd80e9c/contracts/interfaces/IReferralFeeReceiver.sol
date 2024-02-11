// File: ../sc_datasets/DAppSCAN/consensys-1inch_Liquidity_Protocol/liquidity-protocol-d3652c992073efed6367ff93f9e8a18dcbd80e9c/contracts/interfaces/IReferralFeeReceiver.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


interface IReferralFeeReceiver {
    function updateReward(address referral, uint256 referralShare) external;
}
