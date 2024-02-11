// File: ../sc_datasets/DAppSCAN/PeckShield-DSG/core-6f607f77698936e132e4e9b5cb4d75580636d919/contracts/interfaces/ISwapCallee.sol

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
