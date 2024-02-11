// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IStaker.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IStaker{
    function createLock(uint256, uint256) external returns (bool);
    function increaseAmount(uint256) external returns (bool);
    function increaseTime(uint256) external returns (bool);
    function release() external returns (bool);
    function checkpointFeeRewards(address) external;
    function claimFees(address,address,address) external returns (uint256);
    function voteGaugeWeight(address,uint256) external returns (bool);
    function operator() external view returns (address);
    function execute(address _to, uint256 _value, bytes calldata _data) external returns (bool, bytes memory);
}
