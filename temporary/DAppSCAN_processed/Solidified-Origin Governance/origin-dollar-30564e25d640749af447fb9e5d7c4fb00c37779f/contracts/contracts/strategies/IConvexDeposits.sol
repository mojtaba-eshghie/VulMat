// File: ../sc_datasets/DAppSCAN/Solidified-Origin Governance/origin-dollar-30564e25d640749af447fb9e5d7c4fb00c37779f/contracts/contracts/strategies/IConvexDeposits.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

interface IConvexDeposits {
    function deposit(
        uint256 _pid,
        uint256 _amount,
        bool _stake
    ) external returns (bool);

    function deposit(
        uint256 _amount,
        bool _lock,
        address _stakeAddress
    ) external;
}
