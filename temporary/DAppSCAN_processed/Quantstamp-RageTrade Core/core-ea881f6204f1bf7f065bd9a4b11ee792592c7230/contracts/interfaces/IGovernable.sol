// File: ../sc_datasets/DAppSCAN/Quantstamp-RageTrade Core/core-ea881f6204f1bf7f065bd9a4b11ee792592c7230/contracts/interfaces/IGovernable.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface IGovernable {
    function governance() external view returns (address);

    function teamMultisig() external view returns (address);

    function transferGovernance(address newGovernance) external;

    function transferTeamMultisig(address newTeamMultisig) external;
}
