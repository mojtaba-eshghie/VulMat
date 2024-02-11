// File: ../sc_datasets/DAppSCAN/Quantstamp-LI.FI/contracts-7a4a6675f12f7980bde7794b60fb8fc7b3e6c9e8/src/Interfaces/IAnyswapRouter.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IAnyswapRouter {
    function anySwapOutUnderlying(
        address token,
        address to,
        uint256 amount,
        uint256 toChainID
    ) external;

    function anySwapOut(
        address token,
        address to,
        uint256 amount,
        uint256 toChainID
    ) external;

    function anySwapOutNative(
        address token,
        address to,
        uint256 toChainID
    ) external payable;

    function wNATIVE() external returns (address);
}
