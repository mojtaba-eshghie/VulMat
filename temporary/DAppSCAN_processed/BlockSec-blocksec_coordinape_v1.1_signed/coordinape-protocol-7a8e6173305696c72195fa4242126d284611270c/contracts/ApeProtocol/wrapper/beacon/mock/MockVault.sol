// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_coordinape_v1.1_signed/coordinape-protocol-7a8e6173305696c72195fa4242126d284611270c/contracts/ApeProtocol/wrapper/beacon/mock/MockVault.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.2;

contract ApeVaultWrapperImplementation1 {

	uint256 public someValue;
	bool public setup;

	function init() external {
		require(!setup);
		setup = true;
	}

	function write() external {
		someValue = 11;
	}

	function version() external view returns(uint256) {
		return 1;
	}
}

contract ApeVaultWrapperImplementation2 {

	uint256 public someValue;
	bool public setup;

	function init() external {
		require(!setup);
		setup = true;
	}

	function write() external {
		someValue = 22;
	}

	function version() external view returns(uint256) {
		return 2;
	}
}

contract ApeVaultWrapperImplementation3 {

	uint256 public someValue;
	bool public setup;

	function init() external {
		require(!setup);
		setup = true;
	}

	function write() external {
		someValue = 33;
	}

	function version() external view returns(uint256) {
		return 3;
	}
}
