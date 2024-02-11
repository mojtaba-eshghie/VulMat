// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/ERC677Receiver.sol

pragma solidity 0.4.24;


contract ERC677Receiver {
  function onTokenTransfer(address _from, uint _value, bytes _data) external returns(bool);
}
