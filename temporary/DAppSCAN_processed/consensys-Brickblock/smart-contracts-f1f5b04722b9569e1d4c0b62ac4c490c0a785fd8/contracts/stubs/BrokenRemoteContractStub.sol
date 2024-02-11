// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/stubs/BrokenRemoteContractStub.sol

pragma solidity 0.4.23;


contract BrokenRemoteContractStub {
  uint256 public testNumber;

  constructor(
    uint256 _testNumber
  )
    public
  {
    testNumber = _testNumber;
  }

  function add(uint256 _num1, uint256 _num2)
    public
    pure
    returns (uint256)
  {
    // intentionally broken for testing
    return _num1 + _num2 + 3;
  }

  function setTestNumber(uint256 _number)
    public
    returns (uint256)
  {
    testNumber = _number;
    return testNumber;
  }
}
