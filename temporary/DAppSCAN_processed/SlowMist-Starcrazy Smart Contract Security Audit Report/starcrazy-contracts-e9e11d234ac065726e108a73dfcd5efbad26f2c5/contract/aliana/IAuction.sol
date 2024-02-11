// File: ../sc_datasets/DAppSCAN/SlowMist-Starcrazy Smart Contract Security Audit Report/starcrazy-contracts-e9e11d234ac065726e108a73dfcd5efbad26f2c5/contract/aliana/IAuction.sol

pragma solidity ^0.5.0;

/// @title SEKRETOOOO
contract IAuction {
    function isAuction() public returns (bool);

    function getAuction(uint256 _tokenId)
        external
        view
        returns (
            uint256 currentPrice,
            uint256 endAt,
            uint256 gene,
            uint256 lpLabor,
            address buyer,
            bool taked
        );

    function biddingIdList() external view returns (uint256[] memory);

    function tokensOfOwnerAuctionOn(address _owner, bool on)
        external
        view
        returns (uint256[] memory);

    function takeBid(uint256 _tokenId) external;
}
