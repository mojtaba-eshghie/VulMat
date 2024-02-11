// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/modules/interfaces/IexecTokenSpender.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface IexecTokenSpender
{
	function receiveApproval(address,uint256,address,bytes calldata) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-iExec_PoCo/PoCo-a4dfe7891ac60489809cdd4d9c491c8f2e107a82/contracts/tools/testing/TestReceiver.sol

pragma solidity ^0.6.0;

contract TestReceiver is IexecTokenSpender
{
	event GotApproval(address sender, uint256 value, address token, bytes extraData);

	constructor()
	public
	{
	}

	function receiveApproval(
		address        _sender,
		uint256        _value,
		address        _token,
		bytes calldata _extraData)
	external override returns (bool)
	{
		if (_value == 0)
		{
			return false;
		}
		else
		{
			emit GotApproval(_sender, _value, _token, _extraData);
			return true;
		}
	}

}
