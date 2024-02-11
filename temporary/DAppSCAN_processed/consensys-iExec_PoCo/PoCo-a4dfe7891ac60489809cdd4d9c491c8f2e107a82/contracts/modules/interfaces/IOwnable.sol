// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/modules/interfaces/IOwnable.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface IOwnable
{
	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

	function owner() external view returns (address);
	function renounceOwnership() external;
	function transferOwnership(address) external;
}
