// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_coordinape_v1.1_signed/coordinape-protocol-7a8e6173305696c72195fa4242126d284611270c/interfaces/IApeVault.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.2;

interface IApeVault {
	function tap(uint256 _tapValue, uint256 _slippage, uint8 _type) external;
}
