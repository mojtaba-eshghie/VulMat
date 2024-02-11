// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/IWBNB.sol

pragma solidity >=0.5.0;

interface IWBNB {
  function deposit() external payable;

  function transfer(address to, uint256 value) external returns (bool);

  function withdraw(uint256) external;
}
