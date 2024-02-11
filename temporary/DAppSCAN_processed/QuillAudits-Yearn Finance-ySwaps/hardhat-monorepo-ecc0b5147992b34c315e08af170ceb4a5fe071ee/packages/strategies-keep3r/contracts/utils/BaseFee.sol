// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/utils/BaseFee.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract Basefee {
  function basefee_global() external view returns (uint256) {
    return block.basefee;
  }

  function basefee_inline_assembly() external view returns (uint256 ret) {
    assembly {
      ret := basefee()
    }
  }
}
