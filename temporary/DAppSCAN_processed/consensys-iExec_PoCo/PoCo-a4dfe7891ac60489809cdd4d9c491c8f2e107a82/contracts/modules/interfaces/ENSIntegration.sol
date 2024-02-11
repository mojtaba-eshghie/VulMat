// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/modules/interfaces/ENSIntegration.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface ENSIntegration
{
	function setName(address ens, string calldata name) external;
}
