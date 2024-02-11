// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Generic Lender/yearnV2-generic-lender-strat-979ef2f0e5da39ca59a5907c37ba2064fcd6be82/contracts/Interfaces/UniswapInterfaces/IUniswapV2Migrator.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

interface IUniswapV2Migrator {
    function migrate(
        address token,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external;
}
