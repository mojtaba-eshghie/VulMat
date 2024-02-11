// File: ../sc_datasets/DAppSCAN/consensys-Fei_Labs_Flywheel_v2_xTRIBE_xERC4626/flywheel-v2-733d0e1f18090796f07d3f4c208d1ee1f89819c7/src/interfaces/Errors.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.10;

/**
 @title Shared Errors
*/
interface Errors {
    /// @notice thrown when attempting to approve an EOA that must be a contract
    error NonContractError();
}
