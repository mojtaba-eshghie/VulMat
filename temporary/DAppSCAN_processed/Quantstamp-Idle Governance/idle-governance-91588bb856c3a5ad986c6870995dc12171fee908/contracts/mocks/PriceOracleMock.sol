// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Governance/idle-governance-91588bb856c3a5ad986c6870995dc12171fee908/contracts/mocks/PriceOracleMock.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

contract PriceOracleMock {
  mapping (address => uint256) tokenAnswer;

  function setLatestAnswer(address token, uint256 _answer) external returns (uint256) {
    tokenAnswer[token] = _answer;
  }

  function getUnderlyingPrice(address token) external view returns (uint256) {
    return tokenAnswer[token];
  }
}
