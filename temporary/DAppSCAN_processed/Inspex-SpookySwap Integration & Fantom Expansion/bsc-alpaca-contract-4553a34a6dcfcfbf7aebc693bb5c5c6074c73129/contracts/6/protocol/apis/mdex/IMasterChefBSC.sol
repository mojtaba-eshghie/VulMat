// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/apis/mdex/IMasterChefBSC.sol

pragma solidity ^0.6.0;

interface IMasterChefBSC {
  function pendingCake(uint256 pid, address user) external view returns (uint256);

  function deposit(uint256 pid, uint256 amount) external;

  function withdraw(uint256 pid, uint256 amount) external;

  function emergencyWithdraw(uint256 pid) external;
}
