// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/interfaces/IUpgradableTokenFactory.sol

pragma solidity 0.5.8;

/**
 * @title Interface to be implemented by upgradable token factories
 */
interface IUpgradableTokenFactory {

  /**
   * @notice Used to upgrade a token
   * @param _maxModuleType maximum module type enumeration
   */
  function upgradeToken(uint8 _maxModuleType) external;

}
