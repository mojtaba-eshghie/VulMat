// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/mcd/ICat.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract ICat {
  struct Ilk {
    address flip; // Liquidator
    uint256 chop; // Liquidation Penalty   [ray]
    uint256 lump; // Liquidation Quantity  [wad]
  }

  mapping(bytes32 => Ilk) public ilks;
}
