// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/stubs/RemoteContractStub.sol

pragma solidity 0.4.23;


contract RemoteContractStub {
  uint256 public testNumber;
  address public testAddress;

  constructor(
    uint256 _testNumber
  )
    public
  {
    testNumber = _testNumber;
  }

  function add(
    uint256 _num1,
    uint256 _num2
  )
    public
    pure
    returns (uint256)
  {
    return _num1 + _num2;
  }

  function setTestNumber(
    uint256 _number
  )
    public
    returns (bool)
  {
    testNumber = _number;
    return true;
  }
}
