// File: ../sc_datasets/DAppSCAN/Quantstamp-AlphaHomoraV2/alpha-homora-v2-contract-16a6f9ac884ba09d2f8eac99b0038fb8a12e4ee8/interfaces/IWETH.sol

pragma solidity 0.6.12;

interface IWETH {
  function balanceOf(address user) external returns (uint);

  function approve(address to, uint value) external returns (bool);

  function transfer(address to, uint value) external returns (bool);

  function deposit() external payable;

  function withdraw(uint) external;
}
