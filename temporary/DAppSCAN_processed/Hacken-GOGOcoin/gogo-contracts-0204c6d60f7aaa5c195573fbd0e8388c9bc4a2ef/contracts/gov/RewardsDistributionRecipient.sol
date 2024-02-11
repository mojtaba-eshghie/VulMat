// File: ../sc_datasets/DAppSCAN/Hacken-GOGOcoin/gogo-contracts-0204c6d60f7aaa5c195573fbd0e8388c9bc4a2ef/contracts/gov/RewardsDistributionRecipient.sol

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
