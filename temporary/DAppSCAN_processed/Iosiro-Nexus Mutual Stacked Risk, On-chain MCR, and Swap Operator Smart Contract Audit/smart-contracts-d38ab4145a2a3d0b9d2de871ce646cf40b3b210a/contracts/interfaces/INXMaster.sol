// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/interfaces/INXMaster.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface INXMMaster {
  function getLatestAddress(bytes2 _contractName) external view returns (address payable contractAddress);
}
