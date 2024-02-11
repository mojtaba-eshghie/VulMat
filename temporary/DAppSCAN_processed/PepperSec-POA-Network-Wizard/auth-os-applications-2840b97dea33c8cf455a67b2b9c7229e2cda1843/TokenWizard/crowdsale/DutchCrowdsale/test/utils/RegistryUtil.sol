// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/DutchCrowdsale/test/utils/RegistryUtil.sol

pragma solidity ^0.4.23;

contract RegistryUtil {

  function registerApp(bytes32, address, bytes4[], address[]) public pure returns (bytes memory) {
    return msg.data;
  }

  function registerAppVersion(bytes32, bytes32, address, bytes4[], address[]) public pure returns (bytes memory) {
    return msg.data;
  }
}
