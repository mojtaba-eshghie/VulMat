// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/modules/interfaces/IexecCategoryManager.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface IexecCategoryManager
{
	event CreateCategory(uint256 catid, string  name, string  description, uint256 workClockTimeRef);

	function createCategory(string calldata,string calldata,uint256) external returns (uint256);
}
