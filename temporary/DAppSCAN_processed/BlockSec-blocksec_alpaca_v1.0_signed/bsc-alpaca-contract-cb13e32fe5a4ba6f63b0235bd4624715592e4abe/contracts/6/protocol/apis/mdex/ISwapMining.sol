// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/6/protocol/apis/mdex/ISwapMining.sol

pragma solidity 0.6.6;

interface ISwapMining {
  function swap(
    address account,
    address input,
    address output,
    uint256 amount
  ) external returns (bool);
}
