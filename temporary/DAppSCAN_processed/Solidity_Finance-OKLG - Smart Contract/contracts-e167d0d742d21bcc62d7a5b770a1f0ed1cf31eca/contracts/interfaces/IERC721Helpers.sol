// File: ../sc_datasets/DAppSCAN/Solidity_Finance-OKLG - Smart Contract/contracts-e167d0d742d21bcc62d7a5b770a1f0ed1cf31eca/contracts/interfaces/IERC721Helpers.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @dev Interface that can be used to build custom logic for ERC721 tokens..
 */
interface IERC721Helpers {
  /**
   * @dev Returns mint cost in wei.
   */
  function getMintCost(address _address) external view returns (uint256);
}
