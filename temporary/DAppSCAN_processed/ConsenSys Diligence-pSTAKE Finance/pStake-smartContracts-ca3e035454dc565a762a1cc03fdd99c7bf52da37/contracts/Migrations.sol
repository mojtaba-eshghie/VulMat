// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-pSTAKE Finance/pStake-smartContracts-ca3e035454dc565a762a1cc03fdd99c7bf52da37/contracts/Migrations.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

contract Migrations {
	address public owner = msg.sender;
	uint256 public last_completed_migration;

	modifier restricted() {
		require(
			msg.sender == owner,
			"This function is restricted to the contract's owner"
		);
		_;
	}

	function setCompleted(uint256 completed) public restricted {
		last_completed_migration = completed;
	}
}
