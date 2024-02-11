// File: ../sc_datasets/DAppSCAN/QuillAudits-Avatar Art Market Smart Contract/contracts-83897b4075720fe76524d3face58cfebd6bfe667/contracts/interfaces/IAvatarArtMarketPlace.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAvatarArtMarketplace{
    /**
     * @dev User that created sell order can cancel that order
     */ 
    function cancelSellOrder(uint256 tokenId) external returns(bool);
    
    /**
     * @dev Create a sell order to sell BNU category
     */
    function createSellOrder(uint tokenId, uint price) external returns(bool);
    
    /**
     * @dev User purchases a BNU category
     */ 
    function purchase(uint tokenId) external returns(uint);
}
