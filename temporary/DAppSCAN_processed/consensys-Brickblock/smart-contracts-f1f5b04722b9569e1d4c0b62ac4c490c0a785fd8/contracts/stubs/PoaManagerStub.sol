// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/stubs/PoaManagerStub.sol

pragma solidity 0.4.23;

interface IPoaToken {
  function setupContract
  (
    string _name,
    string _symbol,
    // fiat symbol used in ExchangeRates
    string _fiatCurrency,
    address _broker,
    address _custodian,
    uint256 _totalSupply,
    // given as unix time (seconds since 01.01.1970)
    uint256 _startTime,
    // given as seconds
    uint256 _fundingTimeout,
    uint256 _activationTimeout,
    // given as fiat cents
    uint256 _fundingGoalInCents
  )
    external
    returns (bool);
}


contract PoaManagerStub {

  address public registry;

  constructor(
    address _registry
  )
    public
  {
    registry = _registry;
  }

  // Create a PoaToken contract with given parameters, and set active value to true
  function setupPoaToken
  (
    address _tokenAddress,
    string _name,
    string _symbol,
    // fiat symbol used in ExchangeRates
    string _fiatCurrency,
    address _broker,
    address _custodian,
    uint256 _totalSupply,
    // given as unix time (seconds since 01.01.1970)
    uint256 _startTime,
    // given as seconds offset from startTime
    uint256 _fundingTimeout,
    // given as seconds offset from fundingTimeout
    uint256 _activationTimeout,
    // given as fiat cents
    uint256 _fundingGoalInCents
  )
    public
    returns (bool)
  {
    IPoaToken(_tokenAddress).setupContract(
      _name,
      _symbol,
      _fiatCurrency,
      _broker,
      _custodian,
      _totalSupply,
      _startTime,
      _fundingTimeout,
      _activationTimeout,
      _fundingGoalInCents
    );

    return true;
  }
}
