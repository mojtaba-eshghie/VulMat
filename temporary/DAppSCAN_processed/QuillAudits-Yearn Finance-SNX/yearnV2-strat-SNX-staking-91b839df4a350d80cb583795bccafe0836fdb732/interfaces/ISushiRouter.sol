// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-SNX/yearnV2-strat-SNX-staking-91b839df4a350d80cb583795bccafe0836fdb732/interfaces/ISushiRouter.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface ISushiRouter {
    function swapExactTokensForTokens(
        uint256,
        uint256,
        address[] calldata,
        address,
        uint256
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256,
        uint256,
        address[] calldata,
        address,
        uint256
    ) external returns (uint256[] memory amounts);

    function getAmountsOut(uint256 amountIn, address[] memory path)
        external
        view
        returns (uint256[] memory amounts);
}
