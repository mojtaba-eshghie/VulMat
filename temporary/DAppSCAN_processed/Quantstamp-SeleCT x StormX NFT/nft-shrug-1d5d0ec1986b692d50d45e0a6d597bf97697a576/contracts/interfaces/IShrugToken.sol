// File: ../sc_datasets/DAppSCAN/Quantstamp-SeleCT x StormX NFT/nft-shrug-1d5d0ec1986b692d50d45e0a6d597bf97697a576/contracts/interfaces/IShrugToken.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/**
 * @title Shrug ERC-721 Token Interface
 */
interface IShrugToken {
    /**
     * @dev Public Function returns base URI.
     */
    function getBaseURI() external view returns (string memory);

    /**
     * @dev Mint function
     * @param to Address of owner
     * @param tokenId Id of the token
     */
    function mint(
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) external view returns (address);

    /**
     * @dev Burn token function
     * @param tokenId Id of the token
     */
    function burn(
        uint256 tokenId
    ) external;
}
