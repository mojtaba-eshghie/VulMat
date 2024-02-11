// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/common/test/GetSetV0.sol

pragma solidity ^0.5.13;

contract GetSetV0 {
  uint256 public x;

  function get() external view returns (uint256) {
    return x;
  }

  function set(uint256 _x) external {
    x = _x;
  }
}
