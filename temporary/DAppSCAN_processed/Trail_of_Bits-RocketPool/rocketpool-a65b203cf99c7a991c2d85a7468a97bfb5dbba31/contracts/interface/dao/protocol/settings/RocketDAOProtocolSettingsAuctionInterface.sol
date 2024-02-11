// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/dao/protocol/settings/RocketDAOProtocolSettingsAuctionInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAOProtocolSettingsAuctionInterface {
    function getCreateLotEnabled() external view returns (bool);
    function getBidOnLotEnabled() external view returns (bool);
    function getLotMinimumEthValue() external view returns (uint256);
    function getLotMaximumEthValue() external view returns (uint256);
    function getLotDuration() external view returns (uint256);
    function getStartingPriceRatio() external view returns (uint256);
    function getReservePriceRatio() external view returns (uint256);
}
