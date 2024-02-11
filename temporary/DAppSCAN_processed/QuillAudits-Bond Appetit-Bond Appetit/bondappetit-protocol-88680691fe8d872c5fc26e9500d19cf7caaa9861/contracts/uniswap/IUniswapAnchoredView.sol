// File: ../sc_datasets/DAppSCAN/QuillAudits-Bond Appetit-Bond Appetit/bondappetit-protocol-88680691fe8d872c5fc26e9500d19cf7caaa9861/contracts/uniswap/IUniswapAnchoredView.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IUniswapAnchoredView {
    function price(string calldata symbol) external view returns (uint);
}
