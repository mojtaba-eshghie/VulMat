// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/interfaces/IExchangeRateProvider.sol

pragma solidity 0.4.23;

interface IExchangeRateProvider {
  function sendQuery(
    string _queryString,
    uint256 _callInterval,
    uint256 _callbackGasLimit,
    string _queryType
  )
    external
    payable
    returns (bool);

  function setCallbackGasPrice(uint256 _gasPrice)
    external
    returns (bool);

  function selfDestruct(address _address)
    external;
}
