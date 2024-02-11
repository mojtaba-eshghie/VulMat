// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IRewardHook.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IRewardHook{
    enum HookType{
        Deposit,
        Withdraw,
        RewardClaim
    }
    
    function onRewardClaim(HookType _type, uint256 _pid) external;
}
