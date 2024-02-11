// File: ../sc_datasets/DAppSCAN/Hacken-Valhalla/Solidity-70de7d9daccb6d812b2ab96f20fb4aa2605e2601/erc20/IMyNFT.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface MyNFT  {
    function createFromERC20(address sender, uint256 category) external returns (uint256);
}
