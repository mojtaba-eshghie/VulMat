// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/aaveV2/IPriceOracleGetterAave.sol

// SPDX-License-Identifier: agpl-3.0

pragma solidity ^0.7.0;

/************
@title IPriceOracleGetterAave interface
@notice Interface for the Aave price oracle.*/
abstract contract IPriceOracleGetterAave {
  function getAssetPrice(address _asset) external view virtual returns (uint256);

  function getAssetsPrices(address[] calldata _assets)
    external
    view
    virtual
    returns (uint256[] memory);

  function getSourceOfAsset(address _asset) external view virtual returns (address);

  function getFallbackOracle() external view virtual returns (address);
}
