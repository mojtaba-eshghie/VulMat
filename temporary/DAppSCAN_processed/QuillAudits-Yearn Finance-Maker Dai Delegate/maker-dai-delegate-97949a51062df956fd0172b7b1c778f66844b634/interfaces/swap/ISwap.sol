// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Maker Dai Delegate/maker-dai-delegate-97949a51062df956fd0172b7b1c778f66844b634/interfaces/swap/ISwap.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface ISwap {
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
