// File: ../sc_datasets/DAppSCAN/Hacken-PolkaBridge/PolkaBridge-DEX-21b662c48caf08242bfa01621bbbafc957e4ff31/factory/contracts/interfaces/IUniswapV2Callee.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
