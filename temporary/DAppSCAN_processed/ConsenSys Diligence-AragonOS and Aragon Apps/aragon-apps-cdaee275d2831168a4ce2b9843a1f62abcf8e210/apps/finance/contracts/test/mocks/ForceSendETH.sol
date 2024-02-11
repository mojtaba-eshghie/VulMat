// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AragonOS and Aragon Apps/aragon-apps-cdaee275d2831168a4ce2b9843a1f62abcf8e210/apps/finance/contracts/test/mocks/ForceSendETH.sol

pragma solidity 0.4.24;


contract ForceSendETH {
  // Truffle doesn't support selfdestructing on constructor:
  // Error: The contract code couldn't be stored, please check your gas amount.

  function sendByDying(address recipient) external payable {
    selfdestruct(recipient);
  }
}
