// File: ../sc_datasets/DAppSCAN/Quantstamp-AlphaHomoraV2/alpha-homora-v2-contract-16a6f9ac884ba09d2f8eac99b0038fb8a12e4ee8/interfaces/IComptroller.sol

pragma solidity 0.6.12;

interface IComptroller {
  function enterMarkets(address[] memory cTokens) external returns (uint[] memory);
}
