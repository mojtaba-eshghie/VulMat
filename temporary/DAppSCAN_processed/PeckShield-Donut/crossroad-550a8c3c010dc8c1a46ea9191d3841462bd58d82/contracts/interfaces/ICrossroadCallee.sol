// File: ../sc_datasets/DAppSCAN/PeckShield-Donut/crossroad-550a8c3c010dc8c1a46ea9191d3841462bd58d82/contracts/interfaces/ICrossroadCallee.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

interface ICrossroadCallee
{
    function crossroadCall(
        address sender,
        uint256 amountIn,
        uint256 amountOut,
        uint256 amountReward,
        bytes calldata callbackData
        ) external;
}
