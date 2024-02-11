// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IRCNftHubXdai.sol

pragma solidity 0.5.13;

interface IRCNftHubXdai {
    function ownerOf(uint256) external view returns (address);
    function tokenURI(uint256) external view returns (string memory);
    function addMarket(address) external returns (bool);
    function mintNft(address,uint256,string calldata) external returns (bool);
    function transferNft(address,address,uint256) external returns (bool);
    function upgradeCard(address,uint256) external returns (bool);
}
