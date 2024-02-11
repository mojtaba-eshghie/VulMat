// File: ../sc_datasets/DAppSCAN/Quantstamp-Nomad/nomad-monorepo-2111a1d4756a26dfd01a5fb2b1784479e54a2886/solidity/nomad-core/interfaces/IUpdaterManager.sol

// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.6.11;

interface IUpdaterManager {
    function slashUpdater(address payable _reporter) external;

    function updater() external view returns (address);
}
