// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/apis/mdex/ISwapMining.sol

pragma solidity 0.6.6;

interface ISwapMining {
  function swap(
    address account,
    address input,
    address output,
    uint256 amount
  ) external returns (bool);
}
