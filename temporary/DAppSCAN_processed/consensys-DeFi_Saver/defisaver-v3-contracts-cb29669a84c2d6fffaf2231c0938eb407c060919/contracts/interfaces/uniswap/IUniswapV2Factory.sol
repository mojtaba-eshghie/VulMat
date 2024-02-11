// File: ../sc_datasets/DAppSCAN/consensys-DeFi_Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/uniswap/IUniswapV2Factory.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IUniswapV2Factory {
    function getPair(address tokenA, address tokenB) external virtual view returns (address pair);
    function allPairs(uint) external virtual view returns (address pair);
    function allPairsLength() external virtual view returns (uint);
    function feeTo() external virtual view returns (address);
    function feeToSetter() external virtual view returns (address);
}
