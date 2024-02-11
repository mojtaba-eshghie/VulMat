// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/contracts/ERC677Receiver.sol

pragma solidity 0.4.24;


contract ERC677Receiver {
  function onTokenTransfer(address _from, uint _value, bytes _data) external returns(bool);
}
