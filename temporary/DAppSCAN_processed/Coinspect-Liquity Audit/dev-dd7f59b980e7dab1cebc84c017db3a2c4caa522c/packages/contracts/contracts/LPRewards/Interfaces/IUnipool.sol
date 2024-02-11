// File: ../sc_datasets/DAppSCAN/Coinspect-Liquity Audit/dev-dd7f59b980e7dab1cebc84c017db3a2c4caa522c/packages/contracts/contracts/LPRewards/Interfaces/IUnipool.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;


interface IUnipool {
    function setParams(address _lqtyTokenAddress, address _uniTokenAddress, uint256 _duration) external;
    function lastTimeRewardApplicable() external view returns (uint256);
    function rewardPerToken() external view returns (uint256);
    function earned(address account) external view returns (uint256);
    function withdrawAndClaim() external;
    function claimReward() external;
    //function notifyRewardAmount(uint256 reward) external;
}
