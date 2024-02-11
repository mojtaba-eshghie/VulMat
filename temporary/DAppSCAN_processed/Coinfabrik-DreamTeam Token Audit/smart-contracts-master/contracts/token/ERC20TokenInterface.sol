// File: ../sc_datasets/DAppSCAN/Coinfabrik-DreamTeam Token Audit/smart-contracts-master/contracts/token/ERC20TokenInterface.sol

pragma solidity ^0.4.23;

contract ERC20TokenInterface {

    function totalSupply () external constant returns (uint);
    function balanceOf (address tokenOwner) external constant returns (uint balance);
    function transfer (address to, uint tokens) external returns (bool success);
    function transferFrom (address from, address to, uint tokens) external returns (bool success);

}
