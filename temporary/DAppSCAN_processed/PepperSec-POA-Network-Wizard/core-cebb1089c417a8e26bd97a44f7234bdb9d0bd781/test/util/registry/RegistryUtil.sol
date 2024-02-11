// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/util/registry/RegistryUtil.sol

pragma solidity ^0.4.23;

contract RegistryUtil {

  function registerApp(bytes32, address, bytes4[], address[]) public pure returns (bytes memory) {
    return msg.data;
  }

  function registerAppVersion(bytes32, bytes32, address, bytes4[], address[]) public pure returns (bytes memory) {
    return msg.data;
  }
}
