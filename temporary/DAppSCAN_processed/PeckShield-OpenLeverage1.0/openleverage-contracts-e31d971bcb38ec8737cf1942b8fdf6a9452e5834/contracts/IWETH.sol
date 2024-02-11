// File: ../sc_datasets/DAppSCAN/PeckShield-OpenLeverage1.0/openleverage-contracts-e31d971bcb38ec8737cf1942b8fdf6a9452e5834/contracts/IWETH.sol

// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256) external;
}
