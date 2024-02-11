// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/interfaces/ITokenConfiguration.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.12;

/**
 * @title ITokenConfiguration
 * @author Aave
 * @dev Common interface between aTokens and debt tokens to fetch the
 * token configuration
 **/
interface ITokenConfiguration {
  function UNDERLYING_ASSET_ADDRESS() external view returns (address);

  function POOL() external view returns (address);
}
