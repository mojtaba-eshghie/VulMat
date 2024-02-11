// File: ../sc_datasets/DAppSCAN/SlowMist-Starcrazy Smart Contract Security Audit Report/starcrazy-contracts-e9e11d234ac065726e108a73dfcd5efbad26f2c5/contract/aliana/IAlianaSale.sol

pragma solidity ^0.5.0;

/// @title SEKRETOOOO
contract IAlianaSale {
    function getAlianaSaleInfo(uint256 _tokenId)
        external
        view
        returns (
            uint256 beginBlock,
            uint256 price,
            address seller
        );

    function allTokensSale() external view returns (uint256[] memory tokenIds);

    function listTokensSale(uint256 _skip, uint256 _limit)
        external
        view
        returns (uint256[] memory tokenIds);

    function tokensOfOwnerSale(address _owner)
        external
        view
        returns (uint256[] memory ownerTokens);

    function totalSale() public view returns (uint256);
}
