// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/modules/interfaces/IexecERC20.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface IexecERC20
{
	event Transfer(address indexed from, address indexed to, uint256 value);
	event Approval(address indexed owner, address indexed spender, uint256 value);

	function transfer(address,uint256) external returns (bool);
	function approve(address,uint256) external returns (bool);
	function transferFrom(address,address,uint256) external returns (bool);
	function increaseAllowance(address,uint256) external returns (bool);
	function decreaseAllowance(address,uint256) external returns (bool);
	function approveAndCall(address,uint256,bytes calldata) external returns (bool);
}
