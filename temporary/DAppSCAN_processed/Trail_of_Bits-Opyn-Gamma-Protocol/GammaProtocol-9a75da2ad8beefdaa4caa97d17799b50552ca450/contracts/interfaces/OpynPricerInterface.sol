// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn-Gamma-Protocol/GammaProtocol-9a75da2ad8beefdaa4caa97d17799b50552ca450/contracts/interfaces/OpynPricerInterface.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

interface OpynPricerInterface {
    function getPrice() external view returns (uint256);

    function getHistoricalPrice(uint80 _roundId) external view returns (uint256, uint256);
}
