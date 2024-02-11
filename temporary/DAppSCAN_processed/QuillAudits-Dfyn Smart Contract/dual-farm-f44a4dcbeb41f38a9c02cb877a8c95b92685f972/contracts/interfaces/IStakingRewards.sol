// File: ../sc_datasets/DAppSCAN/QuillAudits-Dfyn Smart Contract/dual-farm-f44a4dcbeb41f38a9c02cb877a8c95b92685f972/contracts/interfaces/IStakingRewards.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

interface IStakingRewards {
    // Views
    function lastTimeRewardApplicable() external view returns (uint256);

    function rewardPerToken(address rewardToken) external view returns (uint256);

    function earned(address account, address rewardToken) external view returns (uint256);

    function getRewardForDuration(address rewardToken) external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    // Mutative

    function stake(uint256 amount) external;

    function withdraw(uint256 amount) external;

    function getReward() external;

    function exit() external;
}
