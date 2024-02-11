// File: ../sc_datasets/DAppSCAN/PeckShield-starkex/starkex-contracts-master/scalable-dex/contracts/src/starkex/interfaces/MVaultLocks.sol

// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

/*
  Onchain vaults' lock functionality.
*/
abstract contract MVaultLocks {
    function applyDefaultLock(uint256 assetId, uint256 vaultId) internal virtual;

    function isVaultLocked(
        address ethKey,
        uint256 assetId,
        uint256 vaultId
    ) public view virtual returns (bool);
}
