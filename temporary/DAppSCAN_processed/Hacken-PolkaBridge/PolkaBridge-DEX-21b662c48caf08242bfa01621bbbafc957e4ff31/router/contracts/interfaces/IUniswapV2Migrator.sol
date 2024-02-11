// File: ../sc_datasets/DAppSCAN/Hacken-PolkaBridge/PolkaBridge-DEX-21b662c48caf08242bfa01621bbbafc957e4ff31/router/contracts/interfaces/IUniswapV2Migrator.sol

pragma solidity >=0.5.0;

interface IUniswapV2Migrator {
    function migrate(address token, uint amountTokenMin, uint amountETHMin, address to, uint deadline) external;
}
