// File: ../sc_datasets/DAppSCAN/Quantstamp-Aavegotchi GHST Staking/ghst-staking-af267c0f066794e1944f876f27c35126d931e8c9/contracts/interfaces/IERC165.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

interface IERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceId The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function
    ///  uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
