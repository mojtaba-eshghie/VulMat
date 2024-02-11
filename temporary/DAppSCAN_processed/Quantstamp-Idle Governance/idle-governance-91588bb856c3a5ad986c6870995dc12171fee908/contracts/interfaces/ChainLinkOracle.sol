// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Governance/idle-governance-91588bb856c3a5ad986c6870995dc12171fee908/contracts/interfaces/ChainLinkOracle.sol

pragma solidity 0.6.12;

interface ChainLinkOracle {
  function latestAnswer() external view returns (uint256);
}
