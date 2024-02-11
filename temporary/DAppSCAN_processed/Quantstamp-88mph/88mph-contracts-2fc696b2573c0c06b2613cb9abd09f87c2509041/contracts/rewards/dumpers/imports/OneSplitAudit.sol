// File: ../sc_datasets/DAppSCAN/Quantstamp-88mph/88mph-contracts-2fc696b2573c0c06b2613cb9abd09f87c2509041/contracts/rewards/dumpers/imports/OneSplitAudit.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.5.17;

interface OneSplitAudit {
    function swap(
        address fromToken,
        address destToken,
        uint256 amount,
        uint256 minReturn,
        uint256[] calldata distribution,
        uint256 flags
    ) external payable;

    function getExpectedReturn(
        address fromToken,
        address destToken,
        uint256 amount,
        uint256 parts,
        uint256 flags // See constants in IOneSplit.sol
    )
        external
        view
        returns (uint256 returnAmount, uint256[] memory distribution);
}
