// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/rewards/claims/RocketClaimNodeInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketClaimNodeInterface {
    function getEnabled() external view returns (bool);
    function getClaimPossible(address _nodeAddress) external view returns (bool);
    function getClaimRewardsPerc(address _nodeAddress) external view returns (uint256);
    function getClaimRewardsAmount(address _nodeAddress) external view returns (uint256);
    function register(address _nodeAddress, bool _enable) external;
    function claim() external;
}
