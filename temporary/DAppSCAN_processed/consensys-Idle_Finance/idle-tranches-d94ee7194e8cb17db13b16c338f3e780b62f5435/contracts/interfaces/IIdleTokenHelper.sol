// File: ../sc_datasets/DAppSCAN/consensys-Idle_Finance/idle-tranches-d94ee7194e8cb17db13b16c338f3e780b62f5435/contracts/interfaces/IIdleTokenHelper.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.4;

interface IIdleTokenHelper {
  function getMintingPrice(address idleYieldToken) view external returns (uint256 mintingPrice);
  function getRedeemPrice(address idleYieldToken) view external returns (uint256 redeemPrice);
  function getRedeemPrice(address idleYieldToken, address user) view external returns (uint256 redeemPrice);
}
