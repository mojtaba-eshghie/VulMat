// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/application/functions/init/MockAppOne.sol

pragma solidity ^0.4.23;

library MockAppOne {

  function funcOneAppOne() public pure returns (bytes4) {
    return bytes4(0x65096456);
  }


  function funcTwoAppOne() public pure returns (bytes4) {
    return bytes4(0xc77e14f6);
  }
}
