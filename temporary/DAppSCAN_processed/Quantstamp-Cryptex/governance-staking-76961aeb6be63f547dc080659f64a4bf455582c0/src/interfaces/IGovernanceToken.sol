// File: ../sc_datasets/DAppSCAN/Quantstamp-Cryptex/governance-staking-76961aeb6be63f547dc080659f64a4bf455582c0/src/interfaces/IGovernanceToken.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

interface IGovernanceToken {
   function delegate(address delegatee) external;

   function delegates(address delegator) external returns (address);

   function transfer(address dst, uint256 rawAmount) external returns (bool);

   function transferFrom(
      address src,
      address dst,
      uint256 rawAmount
   ) external returns (bool);

   function balanceOf(address src) external returns (uint256);
}
