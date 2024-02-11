// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/aave/IAaveLendingPool.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAaveLendingPool {
  function flashLoan(
    address receiverAddress,
    address[] calldata assets,
    uint256[] calldata amounts,
    uint256[] calldata modes,
    address onBehalfOf,
    bytes calldata params,
    uint16 referralCode
  ) external;

  function deposit(
    address _asset,
    uint256 _amount,
    address _onBehalfOf,
    uint16 _referralCode
  ) external;

  function withdraw(
    address _asset,
    uint256 _amount,
    address _to
  ) external;

  function borrow(
    address _asset,
    uint256 _amount,
    uint256 _interestRateMode,
    uint16 _referralCode,
    address _onBehalfOf
  ) external;

  function repay(
    address _asset,
    uint256 _amount,
    uint256 _rateMode,
    address _onBehalfOf
  ) external;

  function setUserUseReserveAsCollateral(address _asset, bool _useAsCollateral) external;
}
