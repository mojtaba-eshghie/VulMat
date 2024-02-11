// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-PerpetualProtocolV2/perp-oracle-contract-ba78a5b87098dcffb7285fc585afff1001a87232/contracts/interface/IPriceFeed.sol

// SPDX-License-Identifier: MIT License
pragma solidity 0.7.6;

interface IPriceFeed {
    function decimals() external view returns (uint8);

    /// @dev Returns the index price of the token.
    /// @param interval The interval represents twap interval.
    function getPrice(uint256 interval) external view returns (uint256);
}
