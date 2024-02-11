// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Aave Protocol V2/protocol-v2-750920303e33b66bc29862ea3b85206dda9ce786/contracts/mocks/oracle/IExtendedPriceAggregator.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

interface IExtendedPriceAggregator {
  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);

  function getToken() external view returns (address);

  function getTokenType() external view returns (uint256);

  function getPlatformId() external view returns (uint256);

  function getSubTokens() external view returns (address[] memory);

  function latestAnswer() external view returns (int256);
}
