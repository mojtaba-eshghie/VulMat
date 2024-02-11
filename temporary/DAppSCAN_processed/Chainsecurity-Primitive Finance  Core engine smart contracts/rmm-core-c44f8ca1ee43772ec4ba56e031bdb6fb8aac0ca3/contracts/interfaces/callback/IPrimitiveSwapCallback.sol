// File: ../sc_datasets/DAppSCAN/Chainsecurity-Primitive Finance  Core engine smart contracts/rmm-core-c44f8ca1ee43772ec4ba56e031bdb6fb8aac0ca3/contracts/interfaces/callback/IPrimitiveSwapCallback.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.6;

/// @title  Primitive Swap Callback
/// @author Primitive
interface IPrimitiveSwapCallback {
    /// @notice              Triggered when swapping tokens in an Engine
    /// @param  delRisky     Amount of risky tokens required to pay the swap with
    /// @param  delStable    Amount of stable tokens required to pay the swap with
    /// @param  data         Calldata passed on swap function call
    function swapCallback(
        uint256 delRisky,
        uint256 delStable,
        bytes calldata data
    ) external;
}
