// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-GrowthDeFi WHEAT/wheat-v1-core-8360ac0a537589bb974e8a5a169bb3e7c95d2857/contracts/Migrations.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @dev Truffle migrations contract used for deployment coordination.
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
