// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/IMdexSwapMining.sol

// SPDX-License-Identifier: MIT
/**
  ∩~~~~∩ 
  ξ ･×･ ξ 
  ξ　~　ξ 
  ξ　　 ξ 
  ξ　　 “~～~～〇 
  ξ　　　　　　 ξ 
  ξ ξ ξ~～~ξ ξ ξ 
　 ξ_ξξ_ξ　ξ_ξξ_ξ
Alpaca Fin Corporation
*/

pragma solidity 0.6.6;

interface IMdexSwapMining {
  /// @dev Get rewards from users in the current pool;
  function getUserReward(uint256 pid) external view returns (uint256, uint256);

  /// @dev Withdraws all the transaction rewards of the pool
  function takerWithdraw() external;
}
