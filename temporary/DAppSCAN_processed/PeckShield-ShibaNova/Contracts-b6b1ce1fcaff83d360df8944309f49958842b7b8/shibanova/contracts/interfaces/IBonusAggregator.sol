// File: ../sc_datasets/DAppSCAN/PeckShield-ShibaNova/Contracts-b6b1ce1fcaff83d360df8944309f49958842b7b8/shibanova/contracts/interfaces/IBonusAggregator.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface IBonusAggregator {
    function getBonusOnFarmsForUser(address _user, uint256 _pid) external view returns (uint256);
}
