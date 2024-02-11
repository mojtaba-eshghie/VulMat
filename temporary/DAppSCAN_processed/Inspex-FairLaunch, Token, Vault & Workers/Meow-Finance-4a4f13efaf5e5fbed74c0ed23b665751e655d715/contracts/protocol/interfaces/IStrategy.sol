// File: ../sc_datasets/DAppSCAN/Inspex-FairLaunch, Token, Vault & Workers/Meow-Finance-4a4f13efaf5e5fbed74c0ed23b665751e655d715/contracts/protocol/interfaces/IStrategy.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

interface IStrategy {
  /// @dev Execute worker strategy.
  /// @param user The original user that is interacting with the operator.
  /// @param debt The user's total debt, for better decision making context.
  /// @param data Extra calldata information passed along to this strategy.
  function execute(
    address user,
    uint256 debt,
    bytes calldata data
  ) external;
}
