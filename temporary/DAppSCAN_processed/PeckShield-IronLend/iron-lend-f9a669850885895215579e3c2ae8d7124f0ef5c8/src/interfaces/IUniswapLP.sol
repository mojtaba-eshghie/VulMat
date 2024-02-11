// File: ../sc_datasets/DAppSCAN/PeckShield-IronLend/iron-lend-f9a669850885895215579e3c2ae8d7124f0ef5c8/src/interfaces/IUniswapLP.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;
pragma experimental ABIEncoderV2;

interface IUniswapLP {
    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function getTokenWeights() external view returns (uint32 tokenWeight0, uint32 tokenWeight1);
}
