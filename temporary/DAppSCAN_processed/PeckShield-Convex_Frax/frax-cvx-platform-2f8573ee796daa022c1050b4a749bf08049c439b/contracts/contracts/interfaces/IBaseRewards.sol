// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IBaseRewards.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IBaseRewards{
    function initialize(
        uint256 pid_,
        address stakingToken_,
        address rewardToken_,
        address operator_,
        address rewardManager_
    ) external;
    function addExtraReward(address) external;
    function getReward(address,bool) external;
}
