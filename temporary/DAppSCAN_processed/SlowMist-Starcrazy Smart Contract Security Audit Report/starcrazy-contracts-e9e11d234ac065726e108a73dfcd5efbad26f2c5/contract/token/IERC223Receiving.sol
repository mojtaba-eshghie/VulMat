// File: ../sc_datasets/DAppSCAN/SlowMist-Starcrazy Smart Contract Security Audit Report/starcrazy-contracts-e9e11d234ac065726e108a73dfcd5efbad26f2c5/contract/token/IERC223Receiving.sol

pragma solidity ^0.5.0;

/// @title IERC223Receiving - Standard interface implementation for compatibility with ERC223 tokens.
interface IERC223Receiving {
    /// @dev Function that is called when a user or another contract wants to transfer funds.
    /// @param from_ Transaction initiator, analogue of msg.sender
    /// @param value_ Number of tokens to transfer.
    /// @param data_ Data containig a function signature and/or parameters
    function tokenFallback(
        address from_,
        uint256 value_,
        bytes calldata data_
    ) external;
}
