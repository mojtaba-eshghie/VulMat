// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Generic Lender/yearnV2-generic-lender-strat-979ef2f0e5da39ca59a5907c37ba2064fcd6be82/contracts/Interfaces/UniswapInterfaces/V1/IUniswapV1Exchange.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

interface IUniswapV1Exchange {
    function balanceOf(address owner) external view returns (uint256);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function removeLiquidity(
        uint256,
        uint256,
        uint256,
        uint256
    ) external returns (uint256, uint256);

    function tokenToEthSwapInput(
        uint256,
        uint256,
        uint256
    ) external returns (uint256);

    function ethToTokenSwapInput(uint256, uint256) external payable returns (uint256);
}
