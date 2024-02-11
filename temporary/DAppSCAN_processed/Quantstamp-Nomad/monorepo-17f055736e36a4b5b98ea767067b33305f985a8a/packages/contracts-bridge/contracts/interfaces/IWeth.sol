// File: ../sc_datasets/DAppSCAN/Quantstamp-Nomad/monorepo-17f055736e36a4b5b98ea767067b33305f985a8a/packages/contracts-bridge/contracts/interfaces/IWeth.sol

// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.6.11;

interface IWeth {
    function deposit() external payable;

    function approve(address _who, uint256 _wad) external;
}
