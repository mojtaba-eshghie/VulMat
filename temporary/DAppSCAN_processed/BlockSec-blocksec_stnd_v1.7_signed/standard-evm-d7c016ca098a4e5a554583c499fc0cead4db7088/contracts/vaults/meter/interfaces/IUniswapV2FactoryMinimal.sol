// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/vaults/meter/interfaces/IUniswapV2FactoryMinimal.sol

// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.5.0;

interface IUniswapV2FactoryMinimal {
    function getPair(address tokenA, address tokenB) external view returns (address pair);
}
