// File: ../sc_datasets/DAppSCAN/QuillAudits-AgriUT Smart Contract/AgriUT-2b175e68240e67cfebe30272cb374555f2a460fb/ERC20Interface.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
abstract contract ERC20Interface 
{
    function totalSupply() public virtual view returns (uint256);
    function balanceOf(address tokenOwner) public virtual view returns (uint256);
    function allowance(address tokenOwner, address spender) public virtual view returns (uint256);
    function transfer(address to, uint256 tokens) public virtual returns (bool success);
    function approve(address spender, uint256 tokens) public virtual returns (bool success);
    function transferFrom(address from, address to, uint256 tokens) public virtual returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint256 tokens);
}
