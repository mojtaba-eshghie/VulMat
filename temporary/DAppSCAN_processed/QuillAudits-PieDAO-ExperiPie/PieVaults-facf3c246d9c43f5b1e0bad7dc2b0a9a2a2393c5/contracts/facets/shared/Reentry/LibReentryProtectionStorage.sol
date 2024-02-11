// File: ../sc_datasets/DAppSCAN/QuillAudits-PieDAO-ExperiPie/PieVaults-facf3c246d9c43f5b1e0bad7dc2b0a9a2a2393c5/contracts/facets/shared/Reentry/LibReentryProtectionStorage.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

library LibReentryProtectionStorage {
  bytes32 constant REENTRY_STORAGE_POSITION = keccak256(
    "diamond.standard.reentry.storage"
  );

  struct RPStorage {
    uint256 lockCounter;
  }

  function rpStorage() internal pure returns (RPStorage storage bs) {
    bytes32 position = REENTRY_STORAGE_POSITION;
    assembly {
      bs.slot := position
    }
  }
}
