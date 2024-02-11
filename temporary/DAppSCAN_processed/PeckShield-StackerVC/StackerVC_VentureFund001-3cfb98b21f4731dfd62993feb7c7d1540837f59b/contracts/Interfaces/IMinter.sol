// File: ../sc_datasets/DAppSCAN/PeckShield-StackerVC/StackerVC_VentureFund001-3cfb98b21f4731dfd62993feb7c7d1540837f59b/contracts/Interfaces/IMinter.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.11;

interface IMinter {
	function minters(address) external returns (bool);
	function mint(address, uint256) external;
}
