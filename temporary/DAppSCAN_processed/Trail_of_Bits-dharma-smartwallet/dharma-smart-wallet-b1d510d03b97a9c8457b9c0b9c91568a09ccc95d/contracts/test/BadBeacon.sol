// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-dharma-smartwallet/dharma-smart-wallet-b1d510d03b97a9c8457b9c0b9c91568a09ccc95d/contracts/test/BadBeacon.sol

pragma solidity 0.5.11;


/**
 * @title BadBeacon
 */
contract BadBeacon {
  function () external {
    revert("This is not a working upgrade beacon.");
  }
}
