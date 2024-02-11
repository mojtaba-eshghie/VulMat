// File: ../sc_datasets/DAppSCAN/consensys-Paxos/simple-multisig-master/contracts/TestRegistry.sol

pragma solidity ^0.4.18;

// This contract is only used for testing purposes.
contract TestRegistry {

  mapping(address => uint) public registry;

  function register(uint x) payable public {
    registry[msg.sender] = x;
  }

}
