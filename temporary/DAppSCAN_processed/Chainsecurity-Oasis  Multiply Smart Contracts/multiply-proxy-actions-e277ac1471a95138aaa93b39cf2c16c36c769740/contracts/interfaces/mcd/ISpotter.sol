// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/mcd/IPipInterface.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IPipInterface {
  function read() public virtual returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/interfaces/mcd/ISpotter.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract ISpotter {
  struct Ilk {
    IPipInterface pip;
    uint256 mat;
  }

  mapping(bytes32 => Ilk) public ilks;

  uint256 public par;
}
