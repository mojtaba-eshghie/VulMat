// File: ../sc_datasets/DAppSCAN/PeckShield-PlutosV1/plutos-eth-contract-0777815/contracts/IPDispatcher.sol

pragma solidity >=0.4.21 <0.6.0;

contract IPDispatcher{
  function getTarget(bytes32 _key) public view returns (address);
}
