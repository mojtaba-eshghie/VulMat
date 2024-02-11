// File: ../sc_datasets/DAppSCAN/QuillAudits-GoGocoin Smart Contract/gogo-contracts-f952d59650263cd8e0d403d5a8f3d94890869ba1/contracts/staking/RewardsDistributionRecipient.sol

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

abstract contract RewardsDistributionRecipient {
	address public rewardsDistribution;

	function notifyRewardAmount(uint256 reward) external virtual;

	modifier onlyRewardsDistribution() {
		require(
			msg.sender == rewardsDistribution,
			"Caller is not RewardsDistribution contract"
		);
		_;
	}
}
