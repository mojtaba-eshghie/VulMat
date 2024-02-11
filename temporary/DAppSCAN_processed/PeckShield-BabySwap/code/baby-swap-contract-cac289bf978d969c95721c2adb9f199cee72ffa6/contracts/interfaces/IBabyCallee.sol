// File: ../sc_datasets/DAppSCAN/PeckShield-BabySwap/code/baby-swap-contract-cac289bf978d969c95721c2adb9f199cee72ffa6/contracts/interfaces/IBabyCallee.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface IBabyCallee {
    function babyCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
