// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-ySwaps/hardhat-monorepo-ecc0b5147992b34c315e08af170ceb4a5fe071ee/packages/strategies-keep3r/contracts/interfaces/yearn/IV1Registry.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IV1Registry {
  function wrappedVaults(address _vault) external view returns (address);

  function isDelegatedVault(address _vault) external view returns (bool);

  // Vaults getters
  function getVault(uint256 index) external view returns (address vault);

  function getVaults() external view returns (address[] memory);

  function getVaultInfo(address _vault)
    external
    view
    returns (
      address controller,
      address token,
      address strategy,
      bool isWrapped,
      bool isDelegated
    );

  function getVaultsInfo()
    external
    view
    returns (
      address[] memory controllerArray,
      address[] memory tokenArray,
      address[] memory strategyArray,
      bool[] memory isWrappedArray,
      bool[] memory isDelegatedArray
    );
}
