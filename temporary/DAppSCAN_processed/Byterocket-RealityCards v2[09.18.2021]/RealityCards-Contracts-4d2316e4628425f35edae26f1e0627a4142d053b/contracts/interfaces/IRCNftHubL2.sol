// File: ../sc_datasets/DAppSCAN/Byterocket-RealityCards v2[09.18.2021]/RealityCards-Contracts-4d2316e4628425f35edae26f1e0627a4142d053b/contracts/interfaces/IRCNftHubL2.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

interface IRCNftHubL2 {
    function marketTracker(uint256) external view returns (address);

    function ownerOf(uint256) external view returns (address);

    function tokenURI(uint256) external view returns (string memory);

    function totalSupply() external view returns (uint256 nftCount);

    function mint(
        address,
        uint256,
        string calldata
    ) external;

    function transferNft(
        address,
        address,
        uint256
    ) external;

    function deposit(address user, bytes calldata depositData) external;

    function withdraw(uint256 tokenId) external;

    function withdrawWithMetadata(uint256 tokenId) external;

    function setTokenURI(uint256 _tokenId, string calldata _tokenURI) external;

    function mintCount() external returns (uint256);
}
