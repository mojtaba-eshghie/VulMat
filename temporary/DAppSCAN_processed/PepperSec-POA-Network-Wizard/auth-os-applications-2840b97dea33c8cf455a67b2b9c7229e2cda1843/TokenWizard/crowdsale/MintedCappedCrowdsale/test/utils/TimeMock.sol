// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/test/utils/TimeMock.sol

pragma solidity ^0.4.23;

library TimeMock {

  function getTime() internal view returns (uint time) {
    assembly { time := sload(2) }
    time = time == 0 ? now : time;
  }
}
