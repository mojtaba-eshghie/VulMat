// File: ../sc_datasets/DAppSCAN/PeckShield-XSwap/xswap-326a3246b327cd2b8481fd8c22fe8d864e43b0da/contracts/interface/IERC20Token.sol

pragma solidity ^0.5.4;

interface IERC20Token {
    function balanceOf(address _owner) external view returns (uint);
    function allowance(address _owner, address _spender) external view returns (uint);
    function transfer(address _to, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint _value) external returns (bool success);
    function approve(address _spender, uint _value) external returns (bool success);
    function totalSupply() external view returns (uint);
}

interface NonStandardIERC20Token {
    function balanceOf(address _owner) external view returns (uint);
    function allowance(address _owner, address _spender) external view returns (uint);
    function transfer(address _to, uint _value) external;
    function transferFrom(address _from, address _to, uint _value) external;
    function approve(address _spender, uint _value) external;
}
