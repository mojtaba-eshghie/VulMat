// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/aave/IncentiveController.sol

// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.11;

interface IncentiveController {
  function getRewardsBalance(address[] calldata assets, address user) external view returns(uint256);

  function claimRewards(
    address[] calldata assets,
    uint256 amount,
    address to
    ) external returns (uint256);
}
