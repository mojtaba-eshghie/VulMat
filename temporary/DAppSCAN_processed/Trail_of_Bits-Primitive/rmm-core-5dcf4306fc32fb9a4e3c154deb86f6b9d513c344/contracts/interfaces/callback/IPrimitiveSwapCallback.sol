// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Primitive/rmm-core-5dcf4306fc32fb9a4e3c154deb86f6b9d513c344/contracts/interfaces/callback/IPrimitiveSwapCallback.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >=0.5.0;

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
