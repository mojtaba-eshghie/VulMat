// File: ../sc_datasets/DAppSCAN/PeckShield-BabySwap/code/baby-swap-contract-cac289bf978d969c95721c2adb9f199cee72ffa6/contracts/interfaces/IWETH.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
