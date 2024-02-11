// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IFeeRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IFeeRegistry{
    function cvxfxsIncentive() external view returns(uint256);
    function cvxIncentive() external view returns(uint256);
    function platformIncentive() external view returns(uint256);
    function totalFees() external view returns(uint256);
    function maxFees() external view returns(uint256);
    function feeDeposit() external view returns(address);
}
