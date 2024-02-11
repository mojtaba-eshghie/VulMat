// File: ../sc_datasets/DAppSCAN/SlowMist-CFFv2 Smart Contract Security Audit Report/cff-contract-v2-c86bef3f13c7585f547f9cd0ca900f94664e96b7/contracts/core/IPool.sol

pragma solidity >=0.4.21 <0.6.0;

contract ICurvePool{
  function deposit(uint256 _amount) public;
  function withdraw(uint256 _amount) public;

  function get_virtual_price() public view returns(uint256);

  function get_lp_token_balance() public view returns(uint256);

  function get_lp_token_addr() public view returns(address);

  string public name;
}
