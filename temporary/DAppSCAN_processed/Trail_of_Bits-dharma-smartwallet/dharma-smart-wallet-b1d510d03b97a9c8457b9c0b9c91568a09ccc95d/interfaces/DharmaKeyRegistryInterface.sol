// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-dharma-smartwallet/dharma-smart-wallet-b1d510d03b97a9c8457b9c0b9c91568a09ccc95d/interfaces/DharmaKeyRegistryInterface.sol

pragma solidity 0.5.11;


interface DharmaKeyRegistryInterface {
  function getGlobalKey() external view returns (address globalKey);
  function getKey() external view returns (address key);
  function getKeyForUser(address account) external view returns (address key);
}
