// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit v2/EasyPool-master/contracts/abstract/erc/IERC20Base.sol

pragma solidity ^0.4.24;


/**
 * @title ERC20 Interface 
 */
contract IERC20Base {
    function transfer(address to, uint value) public returns (bool success);
    function balanceOf(address owner) public view returns (uint balance);
}
