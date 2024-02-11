// File: ../sc_datasets/DAppSCAN/Chainsecurity-Angle Protocol  Borrowing Module/angle-borrow-0363b6a137a44e22ee06b3187ba74f7798c1af08/contracts/interfaces/coreModule/IStableMaster.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

/// @title IStableMaster
/// @author Angle Core Team
/// @notice Previous interface with additionnal getters for public variables and mappings
interface IStableMaster {
    function agToken() external returns (address);

    function updateStocksUsers(uint256 amount, address poolManager) external;
}
