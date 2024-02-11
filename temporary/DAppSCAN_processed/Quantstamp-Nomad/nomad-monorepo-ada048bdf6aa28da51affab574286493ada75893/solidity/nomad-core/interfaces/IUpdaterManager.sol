// File: ../sc_datasets/DAppSCAN/Quantstamp-Nomad/nomad-monorepo-ada048bdf6aa28da51affab574286493ada75893/solidity/nomad-core/interfaces/IUpdaterManager.sol

// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.6.11;

interface IUpdaterManager {
    function slashUpdater(address payable _reporter) external;

    function updater() external view returns (address);
}
