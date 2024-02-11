// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-SNX/yearnV2-strat-SNX-staking-91b839df4a350d80cb583795bccafe0836fdb732/interfaces/IAddressResolver.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface IAddressResolver {
    function getAddress(bytes32 name) external view returns (address);

    function getSynth(bytes32 key) external view returns (address);

    function requireAndGetAddress(bytes32 name, string calldata reason)
        external
        view
        returns (address);
}
