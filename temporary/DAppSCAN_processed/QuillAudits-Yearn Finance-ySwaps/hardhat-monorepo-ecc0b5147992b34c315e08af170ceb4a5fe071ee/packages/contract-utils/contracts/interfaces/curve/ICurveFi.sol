// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/contract-utils/contracts/interfaces/curve/ICurveFi.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface ICurveFi {
  function calc_withdraw_one_coin(uint256, int128) external view returns (uint256);

  function remove_liquidity_one_coin(
    uint256,
    int128,
    uint256
  ) external;
}
