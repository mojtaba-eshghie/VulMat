// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/KYCAttributes.sol

pragma solidity ^0.4.24;

/**
 * @title Shared contract for KYC User Attributes
 * @dev You can inherit this contract for convenient access to KYCAttribute
 */
contract KYCAttributes {
  /**
   * @dev Here we define all the built-in KYC Attributes.
   *      Keep in mind, that the deployed contract can handle more attributes
   *      than these (up to 256 in total).
   *
   *      Attributes:
   *      KYCCleared    User have successfully completed KYC
   *      CanPushTokens User can send tokens to any address ("push"), despite of recipients KYC status
   */
  enum KYCAttribute {KYCCleared, CanPushTokens}
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/KYCInterface.sol

pragma solidity ^0.4.18;

interface KYCInterface {
  event AttributesSet(address indexed who, uint256 indexed attributes);

  function getAttribute(address addr, KYCAttributes.KYCAttribute attribute) external view returns (bool);
}
