// File: ../sc_datasets/DAppSCAN/Hacken-GOGOcoin/gogo-contracts-0204c6d60f7aaa5c195573fbd0e8388c9bc4a2ef/contracts/nftBoosting/IGoGoNFTOracle.sol

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

interface IGoGoNFTOracle {
    function getBoostMultiplyer(uint256 tier)
        external
        view
        returns (uint256 multiplyer);
}
