// File: ../sc_datasets/DAppSCAN/Coinfabrik-DreamTeam Smart Contracts Audit for Players Compensation/smart-contracts-c1efcabf8a56a4d0a1fa5185a095052c110bdd87/contracts/token/ERC20TokenInterface.sol

pragma solidity ^0.4.18;

contract ERC20TokenInterface {

    function totalSupply () public constant returns (uint);
    function balanceOf (address tokenOwner) public constant returns (uint balance);
    function transfer (address to, uint tokens) public returns (bool success);
    function transferFrom (address from, address to, uint tokens) public returns (bool success);

}
