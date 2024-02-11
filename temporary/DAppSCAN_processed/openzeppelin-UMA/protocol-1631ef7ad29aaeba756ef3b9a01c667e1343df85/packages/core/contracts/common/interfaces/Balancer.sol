// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/interfaces/Balancer.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @title Interface for Balancer.
 * @dev This only contains the methods/events that we use in our contracts or offchain infrastructure.
 */
abstract contract Balancer {
    function getSpotPriceSansFee(address tokenIn, address tokenOut) external view virtual returns (uint256 spotPrice);
}
