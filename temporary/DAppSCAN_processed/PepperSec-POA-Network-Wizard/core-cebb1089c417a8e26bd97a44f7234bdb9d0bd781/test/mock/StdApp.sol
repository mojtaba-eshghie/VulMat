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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/StdApp.sol

pragma solidity ^0.4.23;

library StdApp {

  bytes4 internal constant STORES = bytes4(keccak256('Store(bytes32[])'));

  // stores to 0 slots
  function std0() external pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(STORES, uint(0)));
  }

  // stores to 1 slot
  function std1(bytes32 _location, bytes32 _val) external pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(STORES, uint(1), _location, _val));
  }

  // stores to 2 slots
  function std2(
    bytes32 _loc1, bytes32 _val1, bytes32 _loc2, bytes32 _val2
  ) external pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      STORES, uint(2), _loc1, _val1, _loc2, _val2
    ));
  }
}
