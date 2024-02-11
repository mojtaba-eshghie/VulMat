// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-Incentives Proposal/incentives-controller-ad534cdedd91d8db5ac1302ef2c200de75377790/contracts/utils/SelfdestructTransfer.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

contract SelfdestructTransfer {
  function destroyAndTransfer(address payable to) external payable {
    selfdestruct(to);
  }
}
