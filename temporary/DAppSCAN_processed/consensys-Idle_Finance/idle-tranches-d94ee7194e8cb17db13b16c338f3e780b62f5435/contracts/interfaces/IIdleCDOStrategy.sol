// File: ../sc_datasets/DAppSCAN/consensys-Idle_Finance/idle-tranches-d94ee7194e8cb17db13b16c338f3e780b62f5435/contracts/interfaces/IIdleCDOStrategy.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.4;

interface IIdleCDOStrategy {
  function strategyToken() external view returns(address);
  function token() external view returns(address);
  function tokenDecimals() external view returns(uint256);
  function oneToken() external view returns(uint256);
  function redeemRewards() external;
  function price() external view returns(uint256);
  function getRewardTokens() external view returns(address[] memory);
  function deposit(uint256 _amount) external returns(uint256);
  // _amount in `strategyToken`
  function redeem(uint256 _amount) external returns(uint256);
  // _amount in `token`
  function redeemUnderlying(uint256 _amount) external returns(uint256);
  function getApr() external view returns(uint256);
}
