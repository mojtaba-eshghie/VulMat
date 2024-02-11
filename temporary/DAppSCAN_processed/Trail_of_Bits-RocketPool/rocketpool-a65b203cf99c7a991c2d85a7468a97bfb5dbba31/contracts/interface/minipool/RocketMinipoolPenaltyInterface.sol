// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/minipool/RocketMinipoolPenaltyInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketMinipoolPenaltyInterface {
    // Max penalty rate
    function setMaxPenaltyRate(uint256 _rate) external;
    function getMaxPenaltyRate() external view returns (uint256);

    // Penalty rate
    function setPenaltyRate(address _minipoolAddress, uint256 _rate) external;
    function getPenaltyRate(address _minipoolAddress) external view returns(uint256);
}
