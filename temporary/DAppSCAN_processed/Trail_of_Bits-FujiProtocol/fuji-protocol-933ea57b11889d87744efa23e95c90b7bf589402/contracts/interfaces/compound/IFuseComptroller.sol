// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/compound/IFuseComptroller.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IFuseComptroller {
  function markets(address) external returns (bool, uint256);

  function enterMarkets(address[] calldata) external returns (uint256[] memory);

  function exitMarket(address cTokenAddress) external returns (uint256);

  function cTokensByUnderlying(address underlyingAsset) external view returns (address);
}
