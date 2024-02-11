// File: ../sc_datasets/DAppSCAN/PeckShield-StackerVC/StackerVC_VentureFund001-3cfb98b21f4731dfd62993feb7c7d1540837f59b/contracts/Interfaces/IUniswapRouterv2.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.11;

interface IUniswapRouterv2 {
	function swapExactTokensForTokens(uint amountIn,uint amountOutMin, address[] calldata path, address to, uint deadline) external returns (uint[] memory amounts);
}
