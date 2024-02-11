// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-dharma-smartwallet/dharma-smart-wallet-b1d510d03b97a9c8457b9c0b9c91568a09ccc95d/contracts/test/UpgradeBeaconImplementationCheck.sol

pragma solidity 0.5.11;


/**
 * @title UpgradeBeaconImplementationCheck
 */
contract UpgradeBeaconImplementationCheck {
  constructor(address beacon, address expectedImplementation) public {
    (bool success, bytes memory returnData) = beacon.staticcall("");
    require(success, "call to beacon failed.");
    require(
      abi.decode(returnData, (address)) == expectedImplementation,
      "returned implementation does not match expected implementation."
    );
  }
}
