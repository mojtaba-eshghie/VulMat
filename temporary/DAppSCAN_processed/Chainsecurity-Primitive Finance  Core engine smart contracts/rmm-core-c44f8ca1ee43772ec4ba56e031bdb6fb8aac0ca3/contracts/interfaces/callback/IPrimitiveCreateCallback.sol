// File: ../sc_datasets/DAppSCAN/Chainsecurity-Primitive Finance  Core engine smart contracts/rmm-core-c44f8ca1ee43772ec4ba56e031bdb6fb8aac0ca3/contracts/interfaces/callback/IPrimitiveCreateCallback.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.6;

/// @title  Primitive Create Callback
/// @author Primitive
interface IPrimitiveCreateCallback {
    /// @notice              Triggered when creating a new pool for an Engine
    /// @param  delRisky     Amount of risky tokens required to initialize risky reserve
    /// @param  delStable    Amount of stable tokens required to initialize stable reserve
    /// @param  data         Calldata passed on create function call
    function createCallback(
        uint256 delRisky,
        uint256 delStable,
        bytes calldata data
    ) external;
}
