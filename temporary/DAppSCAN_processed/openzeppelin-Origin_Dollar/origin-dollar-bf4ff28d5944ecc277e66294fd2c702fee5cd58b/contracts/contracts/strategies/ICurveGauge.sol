// File: ../sc_datasets/DAppSCAN/openzeppelin-Origin_Dollar/origin-dollar-bf4ff28d5944ecc277e66294fd2c702fee5cd58b/contracts/contracts/strategies/ICurveGauge.sol

pragma solidity 0.5.11;

interface ICurveGauge {
    function balanceOf(address account) external view returns (uint256);

    function deposit(uint256 value, address account) external;

    function withdraw(uint256 value) external;
}
