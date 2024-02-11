// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/mcd/IGetCdps.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IGetCdps {
  function getCdpsAsc(address manager, address guy)
    external
    view
    virtual
    returns (
      uint256[] memory ids,
      address[] memory urns,
      bytes32[] memory ilks
    );

  function getCdpsDesc(address manager, address guy)
    external
    view
    virtual
    returns (
      uint256[] memory ids,
      address[] memory urns,
      bytes32[] memory ilks
    );
}
