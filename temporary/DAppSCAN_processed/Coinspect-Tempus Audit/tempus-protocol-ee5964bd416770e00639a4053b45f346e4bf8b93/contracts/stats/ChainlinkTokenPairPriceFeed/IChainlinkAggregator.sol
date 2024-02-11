// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/stats/ChainlinkTokenPairPriceFeed/IChainlinkAggregator.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

// Based on Chainlink's AggregatorV3Interface.sol
// https://github.com/smartcontractkit/chainlink/blob/master/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol
interface IChainlinkAggregator {
    function decimals() external view returns (uint8);

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}
