// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_aloe_1.1_signed/aloe-blend-fd1635d8928c74ed24550d3f0d9a63f284a7f872/contracts/interfaces/IAloeBlendEvents.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IAloeBlendEvents {
    event Deposit(address indexed sender, uint256 shares, uint256 amount0, uint256 amount1);

    event Withdraw(address indexed sender, uint256 shares, uint256 amount0, uint256 amount1);

    event Rebalance(uint32 urgency, uint256 ratio, uint256 shares, uint256 inventory0, uint256 inventory1);

    event Recenter(int24 lower, int24 upper, uint96 magic);
}
