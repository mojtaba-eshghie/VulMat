// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/interfaces/IExchangeRates.sol

pragma solidity 0.4.23;

interface IExchangeRates {
  function queryTypes(
    bytes32 _queryId
  ) 
    external 
    returns (string);

  function ratesActive()
    external
    returns (bool);

  function getRate(
    string _queryType
  )
    external
    view
    returns (uint256);

  function setRate(
    bytes32 _queryId,
    uint256 _rate
  )
    external
    returns (bool);

  function setQueryId(
    bytes32 _queryId,
    string _queryType
  )
    external
    returns (bool);

  function getCurrencySettings(
    string _queryType
  )
    view
    external
    returns (uint256, uint256, string);
}
