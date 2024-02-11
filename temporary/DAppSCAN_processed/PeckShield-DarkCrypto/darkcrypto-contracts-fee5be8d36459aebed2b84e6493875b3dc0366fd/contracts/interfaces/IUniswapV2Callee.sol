// File: ../sc_datasets/DAppSCAN/PeckShield-DarkCrypto/darkcrypto-contracts-fee5be8d36459aebed2b84e6493875b3dc0366fd/contracts/interfaces/IUniswapV2Callee.sol

pragma solidity ^0.6.0;

interface IUniswapV2Callee {
    function uniswapV2Call(
        address sender,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}
