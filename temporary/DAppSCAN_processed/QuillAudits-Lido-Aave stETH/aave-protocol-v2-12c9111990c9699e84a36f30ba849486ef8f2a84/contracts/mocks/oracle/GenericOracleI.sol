// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/mocks/oracle/GenericOracleI.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

interface GenericOracleI {
  // ganache
  event AssetPriceUpdated(address _asset, uint256 _price, uint256 timestamp);
  event EthPriceUpdated(uint256 _price, uint256 timestamp);

  // kovan
  event ProphecySubmitted(
    address indexed _sybil,
    address indexed _asset,
    uint96 _sybilProphecy,
    uint96 _oracleProphecy
  );

  function getAssetPrice(address _asset) external view returns (uint256);

  function getEthUsdPrice() external view returns (uint256);
}
