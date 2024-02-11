// File: ../sc_datasets/DAppSCAN/PeckShield-ERC20_LuckyChip/core-0d957aa387d29297fc6ebfc69140440be6d791c1/contracts/interfaces/ILuckyPower.sol

// SPDX-License-Identifier: MIT
  
pragma solidity 0.6.12;

interface ILuckyPower {
    function updateBonus(address bonusToken, uint256 amount) external;
    function updatePower(address account) external;
    function getPower(address account) external view returns (uint256);
}
