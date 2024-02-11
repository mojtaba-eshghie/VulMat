// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/contracts/classes/token_manager/ITokenManager.sol

pragma solidity ^0.4.23;

interface ITokenManager {
  function getReservedTokenDestinationList() external view returns (uint, address[]);
  function getReservedDestinationInfo(address) external view returns (uint, uint, uint, uint);
}

interface TokenManagerIdx {
  function getReservedTokenDestinationList(address, bytes32) external view returns (uint, address[]);
  function getReservedDestinationInfo(address, bytes32, address) external view returns (uint, uint, uint, uint);
}
