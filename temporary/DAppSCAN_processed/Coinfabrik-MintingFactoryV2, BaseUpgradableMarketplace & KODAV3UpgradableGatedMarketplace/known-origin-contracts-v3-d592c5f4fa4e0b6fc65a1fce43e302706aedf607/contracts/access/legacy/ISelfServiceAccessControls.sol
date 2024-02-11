// File: ../sc_datasets/DAppSCAN/Coinfabrik-MintingFactoryV2, BaseUpgradableMarketplace & KODAV3UpgradableGatedMarketplace/known-origin-contracts-v3-d592c5f4fa4e0b6fc65a1fce43e302706aedf607/contracts/access/legacy/ISelfServiceAccessControls.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface ISelfServiceAccessControls {

    function isEnabledForAccount(address account) external view returns (bool);

}
