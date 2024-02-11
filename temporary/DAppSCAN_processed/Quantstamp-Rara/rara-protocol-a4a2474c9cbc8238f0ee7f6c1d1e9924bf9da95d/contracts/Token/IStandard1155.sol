// File: ../sc_datasets/DAppSCAN/Quantstamp-Rara/rara-protocol-a4a2474c9cbc8238f0ee7f6c1d1e9924bf9da95d/contracts/Token/IStandard1155.sol

//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @dev Interface for the Standard1155 toke contract.
interface IStandard1155 {
    /// @dev Allows a priviledged account to mint tokens to the specified address
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;

    function burn(
        address from,
        uint256 id,
        uint256 amount
    ) external;
}
