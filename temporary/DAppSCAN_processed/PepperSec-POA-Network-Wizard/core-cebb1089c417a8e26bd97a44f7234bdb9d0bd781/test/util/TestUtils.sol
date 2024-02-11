// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/util/TestUtils.sol

pragma solidity ^0.4.23;

contract TestUtils {

  function parseStorageExceptionData(bytes memory _data) public pure returns (address sender, uint wei_sent) {
    require(_data.length == 64);
    assembly {
      sender := mload(add(0x20, _data))
      wei_sent := mload(add(0x40, _data))
    }
  }
}
