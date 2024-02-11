// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/network/RocketNetworkPricesInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketNetworkPricesInterface {
    function getPricesBlock() external view returns (uint256);
    function getRPLPrice() external view returns (uint256);
    function getEffectiveRPLStake() external view returns (uint256);
    function getEffectiveRPLStakeUpdatedBlock() external view returns (uint256);
    function getLatestReportableBlock() external view returns (uint256);
    function inConsensus() external view returns (bool);
    function submitPrices(uint256 _block, uint256 _rplPrice, uint256 _effectiveRplStake) external;
    function executeUpdatePrices(uint256 _block, uint256 _rplPrice, uint256 _effectiveRplStake) external;
    function increaseEffectiveRPLStake(uint256 _amount) external;
    function decreaseEffectiveRPLStake(uint256 _amount) external;
}
