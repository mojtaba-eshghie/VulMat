// File: ../sc_datasets/DAppSCAN/QuillAudits-Bond Appetit-Bond Appetit/bondappetit-protocol-88680691fe8d872c5fc26e9500d19cf7caaa9861/contracts/uniswap/IUniswapV2Factory.sol

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
