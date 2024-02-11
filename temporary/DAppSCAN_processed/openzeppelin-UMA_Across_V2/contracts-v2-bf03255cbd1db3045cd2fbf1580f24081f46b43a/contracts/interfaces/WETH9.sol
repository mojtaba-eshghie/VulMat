// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA_Across_V2/contracts-v2-bf03255cbd1db3045cd2fbf1580f24081f46b43a/contracts/interfaces/WETH9.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

interface WETH9 {
    function withdraw(uint256 wad) external;

    function deposit() external payable;

    function balanceOf(address guy) external view returns (uint256 wad);

    function transfer(address guy, uint256 wad) external;
}
