// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-GrowthDeFi WHEAT/wheat-v1-core-8360ac0a537589bb974e8a5a169bb3e7c95d2857/contracts/IExchange.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @notice Exchange contract iterface. Facilitated the conversion between assets
 *         including liquidity pool shares.
 */
interface IExchange
{
	// view functions
	function calcConversionFromInput(address _from, address _to, uint256 _inputAmount) external view returns (uint256 _outputAmount);
	function calcConversionFromOutput(address _from, address _to, uint256 _outputAmount) external view returns (uint256 _inputAmount);
	function calcJoinPoolFromInput(address _pool, address _token, uint256 _inputAmount) external view returns (uint256 _outputShares);

	// open functions
	function convertFundsFromInput(address _from, address _to, uint256 _inputAmount, uint256 _minOutputAmount) external returns (uint256 _outputAmount);
	function convertFundsFromOutput(address _from, address _to, uint256 _outputAmount, uint256 _maxInputAmount) external returns (uint256 _inputAmount);
	function joinPoolFromInput(address _pool, address _token, uint256 _inputAmount, uint256 _minOutputShares) external returns (uint256 _outputShares);
}
