// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/utils/IBaseFee.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface IBaseFee {
  // solhint-disable-next-line func-name-mixedcase
  function basefee_global() external view returns (uint256 _basefee);
}
