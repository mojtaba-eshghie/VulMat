// File: ../sc_datasets/DAppSCAN/Solidity_Finance-OKLG - Smart Contract/contracts-e167d0d742d21bcc62d7a5b770a1f0ed1cf31eca/contracts/interfaces/IMultiplier.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IMultiplier {
  function getMultiplier(address wallet) external view returns (uint256);
}
