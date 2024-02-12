// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-aeb11d986e3b9280215b748491eeece8f4e6ff02/contracts/interfaces/IShortingRewards.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/istakingrewards
interface IShortingRewards {
    // Views
    function lastTimeRewardApplicable() external view returns (uint256);

    function rewardPerToken() external view returns (uint256);

    function earned(address account) external view returns (uint256);

    function getRewardForDuration() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    // Mutative

    function enrol(address account, uint256 amount) external;

    function withdraw(address account, uint256 amount) external;

    function getReward(address account) external;
}