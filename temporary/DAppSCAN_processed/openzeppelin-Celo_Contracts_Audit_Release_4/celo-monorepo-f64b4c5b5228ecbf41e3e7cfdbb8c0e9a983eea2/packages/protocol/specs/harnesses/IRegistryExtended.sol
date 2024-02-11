// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/specs/harnesses/IRegistryExtended.sol

pragma solidity ^0.5.13;

contract IRegistryExtended {
  /* does not extend IRegistry to avoid overriding issues */
  // SG: Instrumentation
  function isValidating(address) external returns (bool);
  function getTotalWeight() external returns (uint256);
  function getVoterFromAccount(address) external returns (address);
  function getAccountWeight(address) external returns (uint256);
  function getAccountFromVoter(address voter) external returns (address);

}
