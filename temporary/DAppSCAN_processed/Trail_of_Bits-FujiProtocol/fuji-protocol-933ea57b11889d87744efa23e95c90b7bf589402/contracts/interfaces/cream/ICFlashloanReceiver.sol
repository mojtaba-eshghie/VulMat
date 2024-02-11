// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/cream/ICFlashloanReceiver.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ICFlashloanReceiver {
  function onFlashLoan(
    address sender,
    address underlying,
    uint256 amount,
    uint256 fee,
    bytes calldata params
  ) external returns (bytes32);
}
