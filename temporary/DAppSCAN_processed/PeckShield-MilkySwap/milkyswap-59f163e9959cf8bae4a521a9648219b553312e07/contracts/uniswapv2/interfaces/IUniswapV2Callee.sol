// File: ../sc_datasets/DAppSCAN/PeckShield-MilkySwap/milkyswap-59f163e9959cf8bae4a521a9648219b553312e07/contracts/uniswapv2/interfaces/IUniswapV2Callee.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
