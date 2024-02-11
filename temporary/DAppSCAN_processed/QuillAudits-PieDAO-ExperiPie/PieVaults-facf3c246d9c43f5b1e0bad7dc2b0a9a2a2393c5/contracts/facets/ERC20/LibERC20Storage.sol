// File: ../sc_datasets/DAppSCAN/QuillAudits-PieDAO-ExperiPie/PieVaults-facf3c246d9c43f5b1e0bad7dc2b0a9a2a2393c5/contracts/facets/ERC20/LibERC20Storage.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

library LibERC20Storage {
  bytes32 constant ERC_20_STORAGE_POSITION = keccak256(
    // Compatible with pie-smart-pools
    "PCToken.storage.location"
  );

  struct ERC20Storage {
    string name;
    string symbol;
    uint256 totalSupply;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
  }

  function erc20Storage() internal pure returns (ERC20Storage storage es) {
    bytes32 position = ERC_20_STORAGE_POSITION;
    assembly {
      es.slot := position
    }
  }
}
