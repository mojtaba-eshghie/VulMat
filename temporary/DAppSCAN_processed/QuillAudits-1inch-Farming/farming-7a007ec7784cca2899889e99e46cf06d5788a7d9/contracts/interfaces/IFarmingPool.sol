// File: ../sc_datasets/DAppSCAN/QuillAudits-1inch-Farming/farming-7a007ec7784cca2899889e99e46cf06d5788a7d9/contracts/interfaces/IFarmingPool.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IFarmingPool {
    function farmed(address account) external view returns (uint256);
    function farmedPerToken() external view returns (uint256);

    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;
    function claim() external;
    function exit() external;
}
