// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Aave Protocol V2/protocol-v2-750920303e33b66bc29862ea3b85206dda9ce786/contracts/interfaces/ITokenConfiguration.sol

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
