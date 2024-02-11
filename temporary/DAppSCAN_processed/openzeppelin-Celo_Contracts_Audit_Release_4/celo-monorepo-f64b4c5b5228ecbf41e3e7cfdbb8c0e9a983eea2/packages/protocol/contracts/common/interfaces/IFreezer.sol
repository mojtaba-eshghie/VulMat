// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/common/interfaces/IFreezer.sol

pragma solidity ^0.5.13;

interface IFreezer {
  function isFrozen(address) external view returns (bool);
}
