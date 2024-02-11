// File: ../sc_datasets/DAppSCAN/QuillAudits-PieDAO-ExperiPie/PieVaults-facf3c246d9c43f5b1e0bad7dc2b0a9a2a2393c5/contracts/facets/Call/LibCallStorage.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

library LibCallStorage {
  bytes32 constant CALL_STORAGE_POSITION = keccak256(
    "diamond.standard.call.storage"
  );

  struct CallStorage {
    mapping(address => bool) canCall;
    address[] callers;
  }

  function callStorage() internal pure returns (CallStorage storage cs) {
    bytes32 position = CALL_STORAGE_POSITION;
    assembly {
      cs.slot := position
    }
  }
}
