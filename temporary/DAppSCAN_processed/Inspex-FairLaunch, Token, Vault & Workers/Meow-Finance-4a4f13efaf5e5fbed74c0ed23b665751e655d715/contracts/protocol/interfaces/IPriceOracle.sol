// File: ../sc_datasets/DAppSCAN/Inspex-FairLaunch, Token, Vault & Workers/Meow-Finance-4a4f13efaf5e5fbed74c0ed23b665751e655d715/contracts/protocol/interfaces/IPriceOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

interface PriceOracle {
  /// @dev Return the wad price of token0/token1, multiplied by 1e18
  /// NOTE: (if you have 1 token0 how much you can sell it for token1)
  function getPrice(address token0, address token1) external view returns (uint256 price, uint256 lastUpdate);
}
