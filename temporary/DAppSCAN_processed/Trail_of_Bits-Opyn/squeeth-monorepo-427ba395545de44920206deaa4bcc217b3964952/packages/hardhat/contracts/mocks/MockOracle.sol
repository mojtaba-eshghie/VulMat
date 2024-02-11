// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn/squeeth-monorepo-427ba395545de44920206deaa4bcc217b3964952/packages/hardhat/contracts/mocks/MockOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity =0.7.6;

contract MockOracle {
    mapping(address => uint256) public poolPeriodPrice;
    mapping(address => int24) public poolTick;

    function setPrice(address _pool, uint256 _price) external {
        poolPeriodPrice[_pool] = _price;
    }

    function setAverageTick(address _pool, int24 _poolTick) external {
        poolTick[_pool] = _poolTick;
    }

    function getTimeWeightedAverageTickSafe(
        address _pool,
        uint32 /*_period*/
    ) external view returns (int24) {
        return poolTick[_pool];
    }

    function getTwap(
        address _pool,
        address,
        address,
        uint32,
        bool
    ) external view returns (uint256) {
        return poolPeriodPrice[_pool];
    }

    function getMaxPeriod(address) external pure returns (uint32) {
        return uint32(-1);
    }
}
