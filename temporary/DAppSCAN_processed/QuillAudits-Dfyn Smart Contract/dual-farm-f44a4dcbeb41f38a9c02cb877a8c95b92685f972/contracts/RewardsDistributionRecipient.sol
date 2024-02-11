// File: ../sc_datasets/DAppSCAN/QuillAudits-Dfyn Smart Contract/dual-farm-f44a4dcbeb41f38a9c02cb877a8c95b92685f972/contracts/RewardsDistributionRecipient.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

abstract contract RewardsDistributionRecipient {
    address public rewardsDistribution;

    function notifyRewardAmount(address rewardToken, uint256 reward) external virtual;

    modifier onlyRewardsDistribution() {
        require(msg.sender == rewardsDistribution, 'Caller is not RewardsDistribution contract');
        _;
    }
}
