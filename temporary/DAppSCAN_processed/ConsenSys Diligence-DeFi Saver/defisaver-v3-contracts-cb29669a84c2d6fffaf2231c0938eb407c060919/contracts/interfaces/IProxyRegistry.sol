// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-DeFi Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/IProxyRegistry.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IProxyRegistry {
    function proxies(address _owner) public virtual view returns (address);
    function build(address) public virtual returns (address);
}
