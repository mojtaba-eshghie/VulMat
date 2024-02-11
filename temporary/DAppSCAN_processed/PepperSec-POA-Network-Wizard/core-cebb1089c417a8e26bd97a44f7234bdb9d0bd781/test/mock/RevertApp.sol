// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/RevertApp.sol

pragma solidity ^0.4.23;

library RevertApp {

  // Used to check errors when function does not exist
  /* function rev0() public pure { } */

  function rev1() external pure {
    revert();
  }

  function rev2() external pure {
    revert('message');
  }
}
