// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Governance/idle-governance-91588bb856c3a5ad986c6870995dc12171fee908/contracts/mocks/ComptrollerMock.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

contract ComptrollerMock {
  uint256 public speeds;
  function setSpeeds(uint256 speed) public {
    speeds = speed;
  }
  function compSpeeds(address) external view returns (uint256) {
    return speeds;
  }
}
