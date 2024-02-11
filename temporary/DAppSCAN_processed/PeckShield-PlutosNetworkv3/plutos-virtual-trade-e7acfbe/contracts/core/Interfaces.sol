// File: ../sc_datasets/DAppSCAN/PeckShield-PlutosNetworkv3/plutos-virtual-trade-e7acfbe/contracts/core/Interfaces.sol

pragma solidity >=0.4.21 <0.6.0;

contract TokenInterface{
    function generateTokens(address _owner, uint _amount) public returns (bool);
    function destroyTokens(address _owner, uint _amount) public returns (bool);
}
