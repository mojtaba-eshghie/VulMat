// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/aave/IAaveLendingPoolProvider.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAaveLendingPoolProvider {
  function getLendingPool() external view returns (address);
}
