// File: ../sc_datasets/DAppSCAN/Hacken-Forbitspace/forbitspaceX-bep20-19fc2b037b743e9f795709c72f004efe1109aaaf/contracts/interfaces/IPayment.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

interface IPayment {
	function collectBNB() external returns (uint amount);

	function collectTokens(address token) external returns (uint amount);

	function setAdmin(address newAdmin) external ;
}
