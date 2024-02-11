// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/interfaces/ITwapOracle.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface ITwapOracle {
  function pairFor(address tokenA, address tokenB) external view returns (address);
  function consult(address tokenIn, uint amountIn, address tokenOut) external view returns (uint);
  function periodSize() external view returns (uint);
}
