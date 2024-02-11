// File: ../sc_datasets/DAppSCAN/PeckShield-ERC20_LuckyChip/core-0d957aa387d29297fc6ebfc69140440be6d791c1/contracts/interfaces/IMasterChef.sol

// SPDX-License-Identifier: MIT
  
pragma solidity 0.6.12;

interface IMasterChef {
    function getPoolLength() external view returns (uint256);
    function getLuckyPower(address user) external view returns (address[] memory, uint256[] memory, uint256[] memory, uint256, uint256);
}
