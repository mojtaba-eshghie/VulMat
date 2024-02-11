// File: ../sc_datasets/DAppSCAN/QuillAudits-Bond Appetit-Bond Appetit/bondappetit-protocol-355180f0aca0b29d60d808f761052956b7a3a159/contracts/uniswap/IUniswapAnchoredView.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IUniswapAnchoredView {
    function price(string calldata symbol) external view returns (uint);
}
