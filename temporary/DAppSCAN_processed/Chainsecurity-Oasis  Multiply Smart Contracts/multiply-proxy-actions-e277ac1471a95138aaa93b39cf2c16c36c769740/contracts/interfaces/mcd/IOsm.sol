// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/mcd/IOsm.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IOsm {
  mapping(address => uint256) public bud;

  function peep() external view virtual returns (bytes32, bool);
}
