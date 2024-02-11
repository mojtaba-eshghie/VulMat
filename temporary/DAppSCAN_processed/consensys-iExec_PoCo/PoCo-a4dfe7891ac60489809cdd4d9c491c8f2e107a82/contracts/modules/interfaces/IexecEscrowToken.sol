// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/modules/interfaces/IexecEscrowToken.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface IexecEscrowToken
{
	receive() external payable;
	function deposit(uint256) external returns (bool);
	function depositFor(uint256,address) external returns (bool);
	function depositForArray(uint256[] calldata,address[] calldata) external returns (bool);
	function withdraw(uint256) external returns (bool);
	function recover() external returns (uint256);
}
