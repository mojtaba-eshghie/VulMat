// File: ../sc_datasets/DAppSCAN/PeckShield-ShibaNova/Contracts-b6b1ce1fcaff83d360df8944309f49958842b7b8/shibanova/contracts/interfaces/IShibaCallee.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface IShibaCallee {
    function pancakeCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
