// File: ../sc_datasets/DAppSCAN/Quantstamp-Nomad/nomad-monorepo-ada048bdf6aa28da51affab574286493ada75893/solidity/nomad-xapps/interfaces/bridge/IWeth.sol

// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.6.11;
interface IWeth {
    function deposit() external payable;

    function approve(address _who, uint256 _wad) external;
}
