// File: ../sc_datasets/DAppSCAN/PeckShield-Pandora/smart-contract-d0aa3193b8ffcd7fc84481c30e16283837319719/contracts/0.6.x/contracts/interfaces/ISwapCallee.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface ISwapCallee {
    function SwapCall(
        address sender,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}
