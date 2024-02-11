// File: ../sc_datasets/DAppSCAN/Byterocket-Orbit DeFi[05.29.2022]/orbit-defi-541460999b7d8fa80c4a4a86383f583392436b67/interfaces/actions/ICollectFees.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

interface ICollectFees {
    function collectFees(uint256 tokenId, bool returnTokensToUser) external returns (uint256 amount0, uint256 amount1);
}
