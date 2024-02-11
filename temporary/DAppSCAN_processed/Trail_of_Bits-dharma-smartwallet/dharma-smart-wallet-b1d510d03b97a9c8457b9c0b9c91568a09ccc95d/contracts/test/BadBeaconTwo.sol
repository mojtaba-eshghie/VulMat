// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-dharma-smartwallet/dharma-smart-wallet-b1d510d03b97a9c8457b9c0b9c91568a09ccc95d/contracts/test/BadBeaconTwo.sol

pragma solidity 0.5.11;


/**
 * @title BadBeaconTwo
 */
contract BadBeaconTwo {
  function () external {
    if (msg.data.length > 0) {
      revert("This is not an upgradeable upgrade beacon.");
    }

    address implementation = address(0);
    assembly {
      mstore(0, implementation)
      return(0, 32)  
    }
  }
}
