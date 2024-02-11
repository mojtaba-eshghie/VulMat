// File: ../sc_datasets/DAppSCAN/Byterocket-RealityCards v2[09.18.2021]/RealityCards-Contracts-4d2316e4628425f35edae26f1e0627a4142d053b/contracts/interfaces/IRealitio.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

/// @title Realit.io contract interface
interface IRealitio {
    function askQuestion(
        uint256 template_id,
        string calldata question,
        address arbitrator,
        uint32 timeout,
        uint32 opening_ts,
        uint256 nonce
    ) external payable returns (bytes32);

    function resultFor(bytes32 question_id) external view returns (bytes32);

    function isFinalized(bytes32 question_id) external view returns (bool);

    function getContentHash(bytes32 question_id)
        external
        view
        returns (bytes32);
}
