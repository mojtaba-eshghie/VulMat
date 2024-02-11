// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/stealth-txs/contracts/mock/ForceETH.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract ForceETH {
  constructor(address payable _to) payable {
    selfdestruct(_to);
  }
}
