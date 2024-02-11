// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/token/ERC20.sol

pragma solidity ^0.4.24;

contract ERC20 {
    function totalSupply() public view returns (uint256);

    function balanceOf(address _who) public view returns (uint256);

    function allowance(address _owner, address _spender) public view returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

    function approve(address _spender, uint256 _value) public returns (bool);

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
