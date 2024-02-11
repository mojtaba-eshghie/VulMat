// File: ../sc_datasets/DAppSCAN/QuillAudits-Bond Appetit-Bond Appetit/bondappetit-protocol-355180f0aca0b29d60d808f761052956b7a3a159/contracts/uniswap/IUniswapV2Factory.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}
