// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether/pool-contracts-956b9e9dfd41dacd4040c08b5061354cc11897fc/contracts/reserve/ReserveInterface.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.7.0;

/// @title Interface that allows a user to draw an address using an index
interface ReserveInterface {
  function reserveRateMantissa(address prizePool) external view returns (uint256);
}
