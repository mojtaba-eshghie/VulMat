// File: ../sc_datasets/DAppSCAN/PeckShield-XSwap/xswap-326a3246b327cd2b8481fd8c22fe8d864e43b0da/contracts/interface/IXSwap.sol

pragma solidity ^0.5.4;

interface IXSwap {
	function trade(address _input, address _output, uint256 _inputAmount) external returns (bool);
	function trade(address _input, address _output, uint256 _inputAmount, address _receiver) external returns (bool);
}
