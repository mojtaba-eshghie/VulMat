// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/modules/governance/external/Proxy.sol

pragma solidity ^0.5.0;


/**
 * @title Proxy
 * @dev Gives the possibility to delegate any call to a foreign implementation.
 */
contract Proxy {

  /**
  * @dev Fallback function allowing to perform a delegatecall to the given implementation.
  * This function will return whatever the implementation call returns
  */
  // solhint-disable-next-line no-complex-fallback
  function() external payable {
    address _impl = implementation();
    require(_impl != address(0));

    // solhint-disable-next-line no-inline-assembly
    assembly {
      let ptr := mload(0x40)
      calldatacopy(ptr, 0, calldatasize)
      let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
      let size := returndatasize
      returndatacopy(ptr, 0, size)

      switch result
      case 0 {revert(ptr, size)}
      default {return (ptr, size)}
    }
  }

  /**
  * @dev Tells the address of the implementation where every call will be delegated.
  * @return address of the implementation to which it will be delegated
  */
  function implementation() public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/modules/governance/external/UpgradeabilityProxy.sol

pragma solidity ^0.5.0;

/**
 * @title UpgradeabilityProxy
 * @dev This contract represents a proxy where the implementation address to which it will delegate can be upgraded
 */
contract UpgradeabilityProxy is Proxy {
  /**
  * @dev This event will be emitted every time the implementation gets upgraded
  * @param implementation representing the address of the upgraded implementation
  */
  event Upgraded(address indexed implementation);

  // Storage position of the address of the current implementation
  bytes32 private constant IMPLEMENTATION_POSITION = keccak256("org.govblocks.proxy.implementation");

  /**
  * @dev Constructor function
  */
  // solhint-disable-next-line no-empty-blocks
  constructor() public {}

  /**
  * @dev Tells the address of the current implementation
  * @return address of the current implementation
  */
  function implementation() public view returns (address impl) {
    bytes32 position = IMPLEMENTATION_POSITION;
    // solhint-disable-next-line no-inline-assembly
    assembly {
      impl := sload(position)
    }
  }

  /**
  * @dev Sets the address of the current implementation
  * @param _newImplementation address representing the new implementation to be set
  */
  function _setImplementation(address _newImplementation) internal {
    bytes32 position = IMPLEMENTATION_POSITION;
    // solhint-disable-next-line no-inline-assembly
    assembly {
      sstore(position, _newImplementation)
    }
  }

  /**
  * @dev Upgrades the implementation address
  * @param _newImplementation representing the address of the new implementation to be set
  */
  function _upgradeTo(address _newImplementation) internal {
    address currentImplementation = implementation();
    require(currentImplementation != _newImplementation);
    _setImplementation(_newImplementation);
    emit Upgraded(_newImplementation);
  }
}
