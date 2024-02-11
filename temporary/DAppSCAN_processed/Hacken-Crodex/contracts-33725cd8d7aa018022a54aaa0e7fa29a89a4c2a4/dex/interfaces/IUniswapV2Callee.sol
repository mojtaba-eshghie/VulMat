// File: ../sc_datasets/DAppSCAN/Hacken-Crodex/contracts-33725cd8d7aa018022a54aaa0e7fa29a89a4c2a4/dex/interfaces/IUniswapV2Callee.sol

pragma solidity >=0.5.0;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
