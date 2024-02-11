// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-LiquityProtocolandStabilityPoolFinalReport/dev-8cec3fda04b8c71994dc14858386bf6a161164fc/packages/contracts/contracts/LPRewards/Interfaces/IUnipool.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;


interface IUnipool {
    function setParams(address _lqtyTokenAddress, address _uniTokenAddress, uint256 _duration) external;
    function lastTimeRewardApplicable() external view returns (uint256);
    function rewardPerToken() external view returns (uint256);
    function earned(address account) external view returns (uint256);
    function exit() external;
    function claimReward() external;
    //function notifyRewardAmount(uint256 reward) external;
}
