// File: ../sc_datasets/DAppSCAN/Quantstamp-LI.FI/contracts-7a4a6675f12f7980bde7794b60fb8fc7b3e6c9e8/src/Libraries/LibStorage.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

struct LibStorage {
    mapping(address => bool) dexAllowlist;
    mapping(bytes32 => bool) dexFuncSignatureAllowList;
    address[] dexs;
}
