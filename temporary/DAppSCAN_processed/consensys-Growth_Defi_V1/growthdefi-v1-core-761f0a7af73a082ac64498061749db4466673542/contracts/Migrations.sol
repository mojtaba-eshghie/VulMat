// File: ../sc_datasets/DAppSCAN/consensys-Growth_Defi_V1/growthdefi-v1-core-761f0a7af73a082ac64498061749db4466673542/contracts/Migrations.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @dev Truffle migrations contract used deployment coordination.
 */
contract Migrations
{
	address public owner;
	uint256 public last_completed_migration;

	modifier restricted()
	{
		if (msg.sender == owner) _;
	}

	constructor() public
	{
		owner = msg.sender;
	}

	function setCompleted(uint256 _completed) public restricted
	{
		last_completed_migration = _completed;
	}
}
