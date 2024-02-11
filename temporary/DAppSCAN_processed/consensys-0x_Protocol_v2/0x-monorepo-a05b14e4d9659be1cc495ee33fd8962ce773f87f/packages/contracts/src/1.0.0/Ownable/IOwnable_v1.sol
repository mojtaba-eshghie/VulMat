// File: ../sc_datasets/DAppSCAN/consensys-0x_Protocol_v2/0x-monorepo-a05b14e4d9659be1cc495ee33fd8962ce773f87f/packages/contracts/src/1.0.0/Ownable/IOwnable_v1.sol

pragma solidity ^0.4.19;

/*
 * Ownable
 *
 * Base contract with an owner.
 * Provides onlyOwner modifier, which prevents function from running if it is called by anyone other than the owner.
 */

contract IOwnable_v1 {
  
    function owner()
      public view
      returns (address);
  
    function transferOwnership(address newOwner)
      public;
}
