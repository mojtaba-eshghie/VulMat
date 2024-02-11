// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/dependencies/uFragments/UInt256Lib.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title Various utilities useful for uint256.
 */
library UInt256Lib {
  uint256 private constant MAX_INT256 = ~(uint256(1) << 255);

  /**
   * @dev Safely converts a uint256 to an int256.
   */
  function toInt256Safe(uint256 a) internal pure returns (int256) {
    require(a <= MAX_INT256);
    return int256(a);
  }
}
