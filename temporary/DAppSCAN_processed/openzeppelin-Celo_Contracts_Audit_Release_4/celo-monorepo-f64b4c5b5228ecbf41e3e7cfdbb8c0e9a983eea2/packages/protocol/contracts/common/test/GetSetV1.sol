// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/common/test/GetSetV1.sol

pragma solidity ^0.5.13;

contract GetSetV1 {
  uint256 public x;
  string public y;

  function get() external view returns (uint256, string memory) {
    return (x, y);
  }

  function set(uint256 _x, string calldata _y) external {
    x = _x;
    y = _y;
  }
}
