// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/IHarvester.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IHarvester {
  struct Transaction {
    address to;
    bytes data;
  }

  function getHarvestTransaction(uint256 _farmProtocolNum, bytes memory _data)
    external
    returns (address claimedToken, Transaction memory transaction);
}
