// File: ../sc_datasets/DAppSCAN/Solidity_Finance-OKLG - Smart Contract/contracts-e167d0d742d21bcc62d7a5b770a1f0ed1cf31eca/contracts/interfaces/IConditional.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @dev Interface for the Buy Back Reward contract that can be used to build
 * custom logic to elevate user rewards
 */
interface IConditional {
  /**
   * @dev Returns whether a wallet passes the test.
   */
  function passesTest(address wallet) external view returns (bool);
}
