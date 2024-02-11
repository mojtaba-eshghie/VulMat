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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/SecurityTransferAgentInterface.sol

pragma solidity ^0.4.18;

interface SecurityTransferAgent {
  function verify(address from, address to, uint256 value) external view returns (uint256 newValue);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/RestrictedTransferAgent.sol

pragma solidity ^0.4.18;



contract RestrictedTransferAgent is SecurityTransferAgent, KYCAttributes {
  KYCInterface KYC;

  function RestrictedTransferAgent(KYCInterface _KYC) {
    KYC = _KYC;
  }

  /**
   * @dev Checking if transfer can happen, and if so, what is the right amount
   *
   * @param from The account sending the tokens
   * @param to The account receiving the tokens
   * @param value The intended amount
   * @return The actual amount permitted
   */
  function verify(address from, address to, uint256 value) public view returns (uint256 newValue) {
    if (address(KYC) == address(0)) {
      return value;
    }

    if (KYC.getAttribute(to, KYCAttribute.KYCCleared) && KYC.getAttribute(from, KYCAttribute.KYCCleared)) {
      return value;
    } else if (KYC.getAttribute(from, KYCAttribute.CanPushTokens)) {
      return value;
    } else {
      revert("Token transaction not permitted");
    }
  }
}
