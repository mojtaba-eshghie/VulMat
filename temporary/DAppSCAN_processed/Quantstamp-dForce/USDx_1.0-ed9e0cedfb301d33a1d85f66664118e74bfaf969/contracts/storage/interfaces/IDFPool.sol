// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/storage/interfaces/IDFPool.sol

pragma solidity ^0.5.2;

contract IDFPool {
    function transferOut(address _tokenID, address _to, uint _amount) public returns (bool);
    function transferFromSender(address _tokenID, address _from, uint _amount) public returns (bool);
    function transferToCol(address _tokenID, uint _amount) public returns (bool);
    function transferFromSenderToCol(address _tokenID, address _from, uint _amount) public returns (bool);
    function approveToEngine(address _tokenIdx, address _engineAddress) public;
}
