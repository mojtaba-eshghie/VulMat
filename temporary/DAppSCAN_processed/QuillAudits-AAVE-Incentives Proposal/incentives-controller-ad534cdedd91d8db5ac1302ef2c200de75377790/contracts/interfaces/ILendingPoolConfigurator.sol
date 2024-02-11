// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-Incentives Proposal/incentives-controller-ad534cdedd91d8db5ac1302ef2c200de75377790/contracts/interfaces/ILendingPoolConfigurator.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.5;

interface ILendingPoolConfigurator {
  function updateAToken(address reserve, address implementation) external;

  function updateVariableDebtToken(address reserve, address implementation) external;
}
