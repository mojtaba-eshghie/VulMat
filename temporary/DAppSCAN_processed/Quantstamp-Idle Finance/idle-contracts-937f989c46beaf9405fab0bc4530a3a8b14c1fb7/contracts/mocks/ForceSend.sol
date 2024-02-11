// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Finance/idle-contracts-937f989c46beaf9405fab0bc4530a3a8b14c1fb7/contracts/mocks/ForceSend.sol

pragma solidity 0.5.11;
// For test suite
contract ForceSend {
  function go(address payable victim) external payable {
    selfdestruct(victim);
  }
}
