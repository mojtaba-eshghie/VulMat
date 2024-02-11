// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/RevertHelper.sol

pragma solidity ^0.4.23;

library RevertHelper {

  function revertBytes(bytes memory _in) internal pure {
    assembly {
      mstore(sub(_in, 0x20), 0x20)
      revert (sub(_in, 0x20), add(0x40, mload(_in)))
    }
  }
}
