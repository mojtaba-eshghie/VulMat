// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Finance/idle-contracts-937f989c46beaf9405fab0bc4530a3a8b14c1fb7/contracts/interfaces/IERC20Mintable.sol

pragma solidity 0.5.11;

interface IERC20Mintable {
  function totalSupply() external view returns (uint256);
  function balanceOf(address account) external view returns (uint256);
  function transfer(address recipient, uint256 amount) external returns (bool);
  function allowance(address owner, address spender) external view returns (uint256);
  function approve(address spender, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
  function mint(address account, uint256 amount) external returns (bool);
  function mint(uint256 amount) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
