// File: ../sc_datasets/DAppSCAN/Chainsecurity-Angle Protocol  Borrowing Module/angle-borrow-0363b6a137a44e22ee06b3187ba74f7798c1af08/contracts/interfaces/governance/IVeBoostProxy.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

/// @title IVeBoostProxy
/// @author Angle Core Team
/// @notice Interface for the `VeBoostProxy` contract
/// @dev This interface only contains functions of the contract which are called by other contracts
/// of this module
/// @dev The `veBoostProxy` contract used by Angle is a full fork of Curve Finance implementation
interface IVeBoostProxy {
    /// @notice Reads the adjusted veANGLE balance of an address (adjusted by delegation)
    //solhint-disable-next-line
    function adjusted_balance_of(address) external view returns (uint256);
}
