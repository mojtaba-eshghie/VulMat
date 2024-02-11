// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Maker Dai Delegate/maker-dai-delegate-97949a51062df956fd0172b7b1c778f66844b634/interfaces/chainlink/AggregatorInterface.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface AggregatorInterface {
    function latestAnswer() external view returns (int256);

    function latestTimestamp() external view returns (uint256);

    function latestRound() external view returns (uint256);

    function getAnswer(uint256 roundId) external view returns (int256);

    function getTimestamp(uint256 roundId) external view returns (uint256);

    event AnswerUpdated(
        int256 indexed current,
        uint256 indexed roundId,
        uint256 updatedAt
    );

    event NewRound(
        uint256 indexed roundId,
        address indexed startedBy,
        uint256 startedAt
    );
}
