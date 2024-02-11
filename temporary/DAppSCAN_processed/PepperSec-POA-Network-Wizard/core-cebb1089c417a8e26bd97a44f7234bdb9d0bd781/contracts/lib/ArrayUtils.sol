// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/contracts/lib/ArrayUtils.sol

pragma solidity ^0.4.23;

library ArrayUtils {

  function toBytes4Arr(bytes32[] memory _arr) internal pure returns (bytes4[] memory _conv) {
    assembly { _conv := _arr }
  }

  function toAddressArr(bytes32[] memory _arr) internal pure returns (address[] memory _conv) {
    assembly { _conv := _arr }
  }

  function toUintArr(bytes32[] memory _arr) internal pure returns (uint[] memory _conv) {
    assembly { _conv := _arr }
  }
}
