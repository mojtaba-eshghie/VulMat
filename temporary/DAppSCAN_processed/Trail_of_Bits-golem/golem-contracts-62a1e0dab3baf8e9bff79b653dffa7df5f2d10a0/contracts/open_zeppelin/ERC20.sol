// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-golem/golem-contracts-62a1e0dab3baf8e9bff79b653dffa7df5f2d10a0/contracts/open_zeppelin/ERC20Basic.sol

pragma solidity ^0.4.18;


/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-golem/golem-contracts-62a1e0dab3baf8e9bff79b653dffa7df5f2d10a0/contracts/open_zeppelin/ERC20.sol

pragma solidity ^0.4.18;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  // SWC-Transaction Order Dependence: L14
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
