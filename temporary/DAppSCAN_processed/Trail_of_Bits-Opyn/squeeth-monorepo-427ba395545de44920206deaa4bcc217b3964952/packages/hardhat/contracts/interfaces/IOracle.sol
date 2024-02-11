// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn/squeeth-monorepo-427ba395545de44920206deaa4bcc217b3964952/packages/hardhat/contracts/interfaces/IOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity =0.7.6;

interface IOracle {
    function getHistoricalTwap(
        address _pool,
        address _base,
        address _quote,
        uint32 _period,
        uint32 _periodToHistoricPrice
    ) external view returns (uint256);

    function getTwap(
        address _pool,
        address _base,
        address _quote,
        uint32 _period,
        bool _checkPeriod
    ) external view returns (uint256);

    function getMaxPeriod(address _pool) external view returns (uint32);

    function getTimeWeightedAverageTickSafe(address _pool, uint32 _period)
        external
        view
        returns (int24 timeWeightedAverageTick);
}
