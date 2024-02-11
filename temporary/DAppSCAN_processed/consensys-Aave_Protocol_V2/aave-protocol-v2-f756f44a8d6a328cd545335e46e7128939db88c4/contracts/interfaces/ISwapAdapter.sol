// File: ../sc_datasets/DAppSCAN/consensys-Aave_Protocol_V2/aave-protocol-v2-f756f44a8d6a328cd545335e46e7128939db88c4/contracts/interfaces/ISwapAdapter.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

interface ISwapAdapter {
  /**
   * @dev Swaps an `amountToSwap` of an asset to another, approving a `fundsDestination` to pull the funds
   * @param assetToSwapFrom Origin asset
   * @param assetToSwapTo Destination asset
   * @param amountToSwap How much `assetToSwapFrom` needs to be swapped
   * @param fundsDestination Address that will be pulling the swapped funds
   * @param params Additional variadic field to include extra params
   */
  function executeOperation(
    address assetToSwapFrom,
    address assetToSwapTo,
    uint256 amountToSwap,
    address fundsDestination,
    bytes calldata params
  ) external;
}
