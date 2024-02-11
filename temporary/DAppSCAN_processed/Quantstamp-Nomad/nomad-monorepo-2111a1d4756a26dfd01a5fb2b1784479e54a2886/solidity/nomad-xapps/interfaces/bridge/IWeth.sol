// File: ../sc_datasets/DAppSCAN/Quantstamp-Nomad/nomad-monorepo-2111a1d4756a26dfd01a5fb2b1784479e54a2886/solidity/nomad-xapps/interfaces/bridge/IWeth.sol

// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.6.11;
interface IWeth {
    function deposit() external payable;

    function approve(address _who, uint256 _wad) external;
}
