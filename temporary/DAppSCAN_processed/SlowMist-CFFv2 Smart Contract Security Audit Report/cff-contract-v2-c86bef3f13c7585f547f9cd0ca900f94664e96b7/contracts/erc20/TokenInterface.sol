// File: ../sc_datasets/DAppSCAN/SlowMist-CFFv2 Smart Contract Security Audit Report/cff-contract-v2-c86bef3f13c7585f547f9cd0ca900f94664e96b7/contracts/erc20/TokenInterface.sol

pragma solidity >=0.4.21 <0.6.0;
contract TokenInterface{
  function destroyTokens(address _owner, uint _amount) public returns(bool);
  function generateTokens(address _owner, uint _amount) public returns(bool);
}
