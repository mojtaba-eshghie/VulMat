// File: ../sc_datasets/DAppSCAN/QuillAudits-1inch-Farming/farming-7a007ec7784cca2899889e99e46cf06d5788a7d9/contracts/interfaces/IFarm.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IFarm {
    function farmedSinceCheckpointScaled(uint256 checkpoint) external view returns(uint256 amount);
    function claimFor(address account, uint256 amount) external;
}
