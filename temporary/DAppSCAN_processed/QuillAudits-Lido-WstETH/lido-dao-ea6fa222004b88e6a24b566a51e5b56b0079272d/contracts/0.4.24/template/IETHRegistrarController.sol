// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/contracts/0.4.24/template/IETHRegistrarController.sol

// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;

interface IETHRegistrarController {
  function MIN_REGISTRATION_DURATION() external view returns (uint256);
  function minCommitmentAge() external view returns (uint256);
  function maxCommitmentAge() external view returns (uint256);

  function rentPrice(string name, uint256 duration) view external returns (uint256);
  function valid(string name) external pure returns (bool);
  function available(string name) external view returns (bool);
  function makeCommitment(string name, address owner, bytes32 secret) pure external returns (bytes32);
  function commit(bytes32 commitment) external;
  function register(string name, address owner, uint256 duration, bytes32 secret) external payable;
}
