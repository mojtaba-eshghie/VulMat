// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Governance/idle-governance-91588bb856c3a5ad986c6870995dc12171fee908/contracts/interfaces/CERC20.sol

pragma solidity 0.6.12;

interface CERC20 {
  function comptroller() external view returns (address);
  function exchangeRateStored() external view returns (uint256);
}
