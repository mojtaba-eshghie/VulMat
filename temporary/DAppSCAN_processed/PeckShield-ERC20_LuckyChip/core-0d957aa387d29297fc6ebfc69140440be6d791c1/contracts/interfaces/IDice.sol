// File: ../sc_datasets/DAppSCAN/PeckShield-ERC20_LuckyChip/core-0d957aa387d29297fc6ebfc69140440be6d791c1/contracts/interfaces/IDice.sol

// SPDX-License-Identifier: MIT
  
pragma solidity 0.6.12;

interface IDice {
    function tokenAddr() external view returns (address);
    function canWithdrawAmount(uint256 _amount) external view returns (uint256);
}
