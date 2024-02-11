// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/6/protocol/apis/mdex/IMasterChefBSC.sol

pragma solidity ^0.6.0;

interface IMasterChefBSC {
  function pendingCake(uint256 pid, address user) external view returns (uint256);

  function deposit(uint256 pid, uint256 amount) external;

  function withdraw(uint256 pid, uint256 amount) external;

  function emergencyWithdraw(uint256 pid) external;
}
