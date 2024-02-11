// File: ../sc_datasets/DAppSCAN/HAECHI_AUDIT-Fractional/contracts-37f9428fe9a5596c93ed9dfccb7be41afc0646ee/src/OpenZeppelin/mocks/ClashingImplementation.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


/**
 * @dev Implementation contract with an admin() function made to clash with
 * @dev TransparentUpgradeableProxy's to test correct functioning of the
 * @dev Transparent Proxy feature.
 */
contract ClashingImplementation {

  function admin() external pure returns (address) {
    return 0x0000000000000000000000000000000011111142;
  }

  function delegatedFunction() external pure returns (bool) {
    return true;
  }
}
