// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-119164e1624309606db3edd806c520cdd8937743/legacy/common/IERC20.sol

pragma solidity 0.4.25;


contract IERC20 {
    function totalSupply() public view returns (uint);

    function balanceOf(address owner) public view returns (uint);

    function allowance(address owner, address spender) public view returns (uint);

    function transfer(address to, uint value) public returns (bool);

    function approve(address spender, uint value) public returns (bool);

    function transferFrom(
        address from,
        address to,
        uint value
    ) public returns (bool);

    // ERC20 Optional
    function name() public view returns (string);

    function symbol() public view returns (string);

    function decimals() public view returns (uint8);

    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);
}
