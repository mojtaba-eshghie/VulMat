// File: ../sc_datasets/DAppSCAN/Smartdec-MinerOne Smart Contracts Security Analysis/openzeppelin-contracts-1.6.0/contracts/mocks/ReentrancyAttack.sol

pragma solidity ^0.4.18;


contract ReentrancyAttack {

  function callSender(bytes4 data) public {
    require(msg.sender.call(data));
  }

}
