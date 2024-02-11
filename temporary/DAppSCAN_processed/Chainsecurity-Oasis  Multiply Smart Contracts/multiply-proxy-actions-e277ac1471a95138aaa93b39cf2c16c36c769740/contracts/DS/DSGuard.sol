// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/DS/DSGuard.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract DSGuard {
  function canCall(
    address src_,
    address dst_,
    bytes4 sig
  ) public view virtual returns (bool);

  function permit(
    bytes32 src,
    bytes32 dst,
    bytes32 sig
  ) public virtual;

  function forbid(
    bytes32 src,
    bytes32 dst,
    bytes32 sig
  ) public virtual;

  function permit(
    address src,
    address dst,
    bytes32 sig
  ) public virtual;

  function forbid(
    address src,
    address dst,
    bytes32 sig
  ) public virtual;
}

abstract contract DSGuardFactory {
  function newGuard() public virtual returns (DSGuard guard);
}
