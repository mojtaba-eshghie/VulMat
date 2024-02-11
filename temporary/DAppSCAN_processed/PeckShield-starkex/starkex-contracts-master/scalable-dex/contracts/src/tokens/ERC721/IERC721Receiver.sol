// File: ../sc_datasets/DAppSCAN/PeckShield-starkex/starkex-contracts-master/scalable-dex/contracts/src/tokens/ERC721/IERC721Receiver.sol

// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
