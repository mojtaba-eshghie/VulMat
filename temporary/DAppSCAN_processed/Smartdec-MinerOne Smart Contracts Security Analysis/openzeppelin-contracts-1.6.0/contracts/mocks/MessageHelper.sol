// File: ../sc_datasets/DAppSCAN/Smartdec-MinerOne Smart Contracts Security Analysis/openzeppelin-contracts-1.6.0/contracts/mocks/MessageHelper.sol

pragma solidity ^0.4.18;

contract MessageHelper {

  event Show(bytes32 b32, uint256 number, string text);

  function showMessage( bytes32 message, uint256 number, string text ) public returns (bool) {
    Show(message, number, text);
    return true;
  }

  function fail() public {
    require(false);
  }

  function call(address to, bytes data) public returns (bool) {
    if (to.call(data))
      return true;
    else
      return false;
  }

}
