// File: ../sc_datasets/DAppSCAN/PeckShield-AaveV3/code/aave-v3-core-14f6148e21b477d78347db6a1603039c9559e275/contracts/mocks/helpers/SelfDestructTransfer.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

contract SelfdestructTransfer {
  function destroyAndTransfer(address payable to) external payable {
    selfdestruct(to);
  }
}
