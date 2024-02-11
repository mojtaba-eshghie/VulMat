// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/converter/interfaces/IDFProtocol.sol

pragma solidity ^0.5.2;

contract IDFProtocol {
    function deposit(address _tokenID, uint _feeTokenIdx, uint _amount) public returns (uint _balance);
    function withdraw(address _tokenID, uint _feeTokenIdx, uint _amount) public returns (uint _balance);
    function destroy(uint _feeTokenIdx, uint _amount) public;
    function claim(uint _feeTokenIdx) public returns (uint _balance);
    function oneClickMinting(uint _feeTokenIdx, uint _amount) public;
}
