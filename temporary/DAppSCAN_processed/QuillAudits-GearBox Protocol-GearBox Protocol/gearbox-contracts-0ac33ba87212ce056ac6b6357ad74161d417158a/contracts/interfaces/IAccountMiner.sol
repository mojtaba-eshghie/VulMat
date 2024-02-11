// File: ../sc_datasets/DAppSCAN/QuillAudits-GearBox Protocol-GearBox Protocol/gearbox-contracts-0ac33ba87212ce056ac6b6357ad74161d417158a/contracts/interfaces/IAccountMiner.sol

// SPDX-License-Identifier: BSL-1.1
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox.fi, 2021
pragma solidity ^0.7.4;

interface IAccountMiner {
    /// @dev Pays gas compensation for user
    function mineAccount(address payable user) external;

    /// @dev Returns account miner type
    function kind() external pure returns (bytes32);
}
