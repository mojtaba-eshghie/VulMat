// File: ../sc_datasets/DAppSCAN/Solidity_Finance-OKLG - Smart Contract/contracts-e167d0d742d21bcc62d7a5b770a1f0ed1cf31eca/contracts/interfaces/IUnlockCondition.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @dev Interface used by Unicrypt token locker/vester for premature unlock condition
 */
interface IUnlockCondition {
  function unlockTokens() external view returns (bool);
}
