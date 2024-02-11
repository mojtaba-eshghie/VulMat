// File: ../sc_datasets/DAppSCAN/Hacken-Crodex/contracts-33725cd8d7aa018022a54aaa0e7fa29a89a4c2a4/staking/interfaces/IStakingRewards.sol

pragma solidity >=0.4.24;


interface IStakingRewards {
    // Views
    function lastTimeRewardApplicable() external view returns (uint256);

    function rewardPerToken() external view returns (uint256);

    function earned(address account) external view returns (uint256);

    function getRewardForDuration() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    // Mutative

    function stake(uint256 amount) external;

    function withdraw(uint256 amount) external;

    function getReward() external;

    function exit() external;
}
