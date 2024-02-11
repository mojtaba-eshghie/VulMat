// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IBooster.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IBooster {
   function addPool(address _implementation, address _stakingAddress, address _stakingToken) external;
   function deactivatePool(uint256 _pid) external;
   function voteGaugeWeight(address _controller, address _gauge, uint256 _weight) external;
   function setDelegate(address _delegateContract, address _delegate, bytes32 _space) external;
   function owner() external returns(address);
   function rewardManager() external returns(address);
}
