// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/mcd/IJug.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IJug {
  struct Ilk {
    uint256 duty;
    uint256 rho;
  }

  mapping(bytes32 => Ilk) public ilks;

  function drip(bytes32) public virtual returns (uint256);
}
