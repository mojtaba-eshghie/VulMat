// File: ../sc_datasets/DAppSCAN/Quantstamp-88mph/88mph-contracts-2fc696b2573c0c06b2613cb9abd09f87c2509041/contracts/moneymarkets/harvest/imports/HarvestStaking.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.5.17;

interface HarvestStaking {
    function stake(uint256 amount) external;

    function withdraw(uint256 amount) external;

    function getReward() external;

    function rewardToken() external returns (address);

    function balanceOf(address account) external view returns (uint256);
}
