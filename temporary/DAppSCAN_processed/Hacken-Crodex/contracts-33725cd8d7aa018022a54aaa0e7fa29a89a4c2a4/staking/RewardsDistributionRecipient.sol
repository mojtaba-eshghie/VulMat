// File: ../sc_datasets/DAppSCAN/Hacken-Crodex/contracts-33725cd8d7aa018022a54aaa0e7fa29a89a4c2a4/staking/RewardsDistributionRecipient.sol

pragma solidity ^0.5.16;

contract RewardsDistributionRecipient {
    address public rewardsDistribution;

    function notifyRewardAmount(uint256 reward) external;

    modifier onlyRewardsDistribution() {
        require(msg.sender == rewardsDistribution, "Caller is not RewardsDistribution contract");
        _;
    }
}
