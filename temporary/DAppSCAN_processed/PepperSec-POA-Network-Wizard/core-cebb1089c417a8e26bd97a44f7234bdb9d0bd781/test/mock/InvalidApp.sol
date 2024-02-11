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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/InvalidApp.sol

pragma solidity ^0.4.23;

library InvalidApp {

  bytes4 internal constant EMITS = bytes4(keccak256('Emit((bytes32[],bytes)[])'));
  bytes4 internal constant STORES = bytes4(keccak256('Store(bytes32[])'));
  bytes4 internal constant PAYS = bytes4(keccak256('Pay(bytes32[])'));

  // attempts to pay the storage contract
  function inv1() external view {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      PAYS, uint(1), uint(5), address(this)
    ));
  }

  // does not change state
  function inv2() external pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      EMITS, uint(0), STORES, uint(0), PAYS, uint(0)
    ));
  }
}
