// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-Tracer_Perpetual_Pools_V2/perpetual-pools-contracts-846bbf62652d7c83aee1cf3766275c4d08b00c8a/contracts/test-utilities/IChainlinkOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/**
 * This interface follows the AggregatorV3 interface. The getRoundData has been excluded as only the
 * latestRoundData function is used in the system to fetch answers.
 * https://github.com/smartcontractkit/chainlink/blob/develop/evm-contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
 * Before being used by the system, any Chainlink feeds that do not provide answers in WAD format (18 decimals) should be wrapped in a
 * Tracer Chainlink Adapter (see contrafts/oracle/ChainlinkOracleAdapter.sol) to ensure the correct number of decimals.
 */
interface IChainlinkOracle {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    // latestRoundData should raise "No data present"
    // if they do not have data to report, instead of returning unset values
    // which could be misinterpreted as actual reported values.
    function latestRoundData()
        external
        view
        returns (
            uint80,
            int256,
            uint256,
            uint256,
            uint80
        );
}
