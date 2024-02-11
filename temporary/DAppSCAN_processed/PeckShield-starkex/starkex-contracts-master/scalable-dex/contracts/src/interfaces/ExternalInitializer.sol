// File: ../sc_datasets/DAppSCAN/PeckShield-starkex/starkex-contracts-master/scalable-dex/contracts/src/interfaces/ExternalInitializer.sol

// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

interface ExternalInitializer {
    event LogExternalInitialize(bytes data);

    function initialize(bytes calldata data) external;
}
