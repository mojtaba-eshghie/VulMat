// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Primitive/rmm-core-5dcf4306fc32fb9a4e3c154deb86f6b9d513c344/contracts/interfaces/callback/IPrimitiveDepositCallback.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >=0.5.0;

/// @title  Primitive Deposit Callback
/// @author Primitive
interface IPrimitiveDepositCallback {
    /// @notice              Triggered when depositing tokens to an Engine
    /// @param  delRisky     Amount of risky tokens required to deposit to risky margin balance
    /// @param  delStable    Amount of stable tokens required to deposit to stable margin balance
    /// @param  data         Calldata passed on deposit function call
    function depositCallback(
        uint256 delRisky,
        uint256 delStable,
        bytes calldata data
    ) external;
}
