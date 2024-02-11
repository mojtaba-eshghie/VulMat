// File: ../sc_datasets/DAppSCAN/Coinfabrik-Worldbit Token Sale Smart Contract Audit/ico-world-bit/contracts/Mintable.sol

pragma solidity ^0.4.18;

/**
 * Authored by https://www.coinfabrik.com/
 */


/**
 * Internal interface for the minting of tokens.
 */
contract Mintable {

  /**
   * @dev Mints tokens for an account
   * This function should emit the Minted event.
   */
  function mintInternal(address receiver, uint amount) internal;

  /** Token supply got increased and a new owner received these tokens */
  event Minted(address receiver, uint amount);
}
