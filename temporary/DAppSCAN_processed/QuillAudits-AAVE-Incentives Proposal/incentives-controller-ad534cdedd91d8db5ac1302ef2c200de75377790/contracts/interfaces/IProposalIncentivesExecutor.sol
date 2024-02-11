// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-Incentives Proposal/incentives-controller-ad534cdedd91d8db5ac1302ef2c200de75377790/contracts/interfaces/IProposalIncentivesExecutor.sol

// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.7.5;

interface IProposalIncentivesExecutor {
  function execute(
    address[6] memory aTokenImplementations,
    address[6] memory variableDebtImplementation
  ) external;
}
