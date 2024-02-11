// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether_Pods/pods-v3-contracts-879dc8b911fc506dd6bead1f36eade919ccfea57/contracts/interfaces/TokenControllerInterface.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

/// @title Controlled ERC20 Token Interface
/// @notice Required interface for Controlled ERC20 Tokens linked to a Prize Pool
/// @dev Defines the spec required to be implemented by a Controlled ERC20 Token
interface TokenControllerInterface {
    /// @dev Controller hook to provide notifications & rule validations on token transfers to the controller.
    /// This includes minting and burning.
    /// @param from Address of the account sending the tokens (address(0x0) on minting)
    /// @param to Address of the account receiving the tokens (address(0x0) on burning)
    /// @param amount Amount of tokens being transferred
    function beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) external;
}
