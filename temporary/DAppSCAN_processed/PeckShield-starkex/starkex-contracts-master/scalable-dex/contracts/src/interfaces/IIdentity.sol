// File: ../sc_datasets/DAppSCAN/PeckShield-starkex/starkex-contracts-master/scalable-dex/contracts/src/interfaces/IIdentity.sol

// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

interface IIdentity {
    /*
      Allows a caller to ensure that the provided address is of the expected type and version.
    */
    function identify() external pure returns (string memory);
}
