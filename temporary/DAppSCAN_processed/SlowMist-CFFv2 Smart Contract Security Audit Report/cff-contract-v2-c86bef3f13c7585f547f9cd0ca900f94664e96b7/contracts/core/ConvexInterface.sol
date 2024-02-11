// File: ../sc_datasets/DAppSCAN/SlowMist-CFFv2 Smart Contract Security Audit Report/cff-contract-v2-c86bef3f13c7585f547f9cd0ca900f94664e96b7/contracts/core/ConvexInterface.sol

pragma solidity >=0.4.21 <0.6.0;

contract ConvexRewardInterface{
function getReward(address, bool) external returns(bool);
function withdraw(uint256, bool) external returns(bool);
}

contract ConvexBoosterInterface{
  function poolInfo(uint256) external view returns(address,address,address,address,address,bool);
  function poolLength() external view returns (uint256);
  function depositAll(uint256 _pid, bool _stake) external returns(bool);
  function withdraw(uint256 _pid, uint256 _amount) public returns(bool);
}
