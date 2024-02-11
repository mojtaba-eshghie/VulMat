// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-Incentives Proposal/incentives-controller-ad534cdedd91d8db5ac1302ef2c200de75377790/contracts/interfaces/IAaveEcosystemReserveController.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.5;

interface IAaveEcosystemReserveController {
  function AAVE_RESERVE_ECOSYSTEM() external view returns (address);

  function approve(
    address token,
    address recipient,
    uint256 amount
  ) external;

  function owner() external view returns (address);

  function renounceOwnership() external;

  function transfer(
    address token,
    address recipient,
    uint256 amount
  ) external;

  function transferOwnership(address newOwner) external;
}
