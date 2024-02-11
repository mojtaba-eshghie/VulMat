// File: ../sc_datasets/DAppSCAN/SlowMist-DODO-NFTPool Smart Contract Security Audit Report/contractV2-e16ceb038ed6bf070ea75d9359c7ad54e6f3e226/contracts/intf/IDODONFTApprove.sol

/*

    Copyright 2021 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;

interface IDODONFTApprove {
    function isAllowedProxy(address _proxy) external view returns (bool);

    function claimERC721(address nftContract, address who, address dest, uint256 tokenId) external;

    function claimERC1155(address nftContract, address who, address dest, uint256 tokenId, uint256 amount) external;

    function claimERC1155Batch(address nftContract, address who, address dest, uint256[] memory tokenIds, uint256[] memory amounts) external;
}
