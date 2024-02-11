// File: ../sc_datasets/DAppSCAN/Quantstamp-LI.FI/contracts-7a4a6675f12f7980bde7794b60fb8fc7b3e6c9e8/src/Interfaces/IERC173.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/// @title ERC-173 Contract Ownership Standard
///  Note: the ERC-165 identifier for this interface is 0x7f5828d0
/* is ERC165 */
interface IERC173 {
    /// @dev This emits when ownership of a contract changes.
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /// @notice Get the address of the owner
    /// @return owner_ The address of the owner.
    function owner() external view returns (address owner_);

    /// @notice Set the address of the new owner of the contract
    /// @dev Set _newOwner to address(0) to renounce any ownership.
    /// @param _newOwner The address of the new owner of the contract
    function transferOwnership(address _newOwner) external;
}
