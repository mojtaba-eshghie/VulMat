// File: ../sc_datasets/DAppSCAN/openzeppelin-Origin_Dollar/origin-dollar-bf4ff28d5944ecc277e66294fd2c702fee5cd58b/contracts/contracts/strategies/IAaveStakeToken.sol

pragma solidity 0.5.11;

interface IAaveStakedToken {
    function COOLDOWN_SECONDS() external returns (uint256);

    function UNSTAKE_WINDOW() external returns (uint256);

    function balanceOf(address addr) external returns (uint256);

    function redeem(address to, uint256 amount) external;

    function stakersCooldowns(address addr) external returns (uint256);

    function cooldown() external;
}
