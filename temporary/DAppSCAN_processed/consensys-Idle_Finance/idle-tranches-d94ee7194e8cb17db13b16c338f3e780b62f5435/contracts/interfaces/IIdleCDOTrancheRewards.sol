// File: ../sc_datasets/DAppSCAN/consensys-Idle_Finance/idle-tranches-d94ee7194e8cb17db13b16c338f3e780b62f5435/contracts/interfaces/IIdleCDOTrancheRewards.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.4;

interface IIdleCDOTrancheRewards {
  function stake(uint256 _amount) external;
  function unstake(uint256 _amount) external;
  function depositReward(address _reward, uint256 _amount) external;
}
