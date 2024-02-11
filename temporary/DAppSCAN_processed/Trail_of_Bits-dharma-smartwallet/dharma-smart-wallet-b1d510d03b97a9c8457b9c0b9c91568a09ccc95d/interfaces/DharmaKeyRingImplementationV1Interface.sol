// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-dharma-smartwallet/dharma-smart-wallet-b1d510d03b97a9c8457b9c0b9c91568a09ccc95d/interfaces/DharmaKeyRingImplementationV1Interface.sol

pragma solidity 0.5.11;


interface DharmaKeyRingImplementationV1Interface {
  event ThresholdModified(uint256 standard, uint256 admin);

  struct AdditionalThreshold {
    uint128 standard;
    uint128 admin;
  }

  function takeAction(
    address payable to, uint256 value, bytes calldata data, bytes calldata signatures
  ) external returns (bool ok, bytes memory returnData);

  function getActionID(
    address payable to, uint256 value, bytes calldata data
  ) external view returns (bytes32 actionID);
}
