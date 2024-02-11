// File: ../sc_datasets/DAppSCAN/PeckShield-Donut/crossroad-550a8c3c010dc8c1a46ea9191d3841462bd58d82/contracts/interfaces/IUniswapFactory.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

interface IUniswapFactory
{
    function getPair(address tokenA, address tokenB) external view returns (address);
    function createPair(address tokenA, address tokenB) external returns (address);
}
