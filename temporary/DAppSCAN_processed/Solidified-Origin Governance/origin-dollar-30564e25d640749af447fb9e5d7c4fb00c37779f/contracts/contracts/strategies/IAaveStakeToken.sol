// File: ../sc_datasets/DAppSCAN/Solidified-Origin Governance/origin-dollar-30564e25d640749af447fb9e5d7c4fb00c37779f/contracts/contracts/strategies/IAaveStakeToken.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

interface IAaveStakedToken {
    function COOLDOWN_SECONDS() external returns (uint256);

    function UNSTAKE_WINDOW() external returns (uint256);

    function balanceOf(address addr) external returns (uint256);

    function redeem(address to, uint256 amount) external;

    function stakersCooldowns(address addr) external returns (uint256);

    function cooldown() external;
}
