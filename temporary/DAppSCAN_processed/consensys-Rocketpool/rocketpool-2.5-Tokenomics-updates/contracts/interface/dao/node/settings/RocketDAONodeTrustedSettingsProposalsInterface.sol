// File: ../sc_datasets/DAppSCAN/consensys-Rocketpool/rocketpool-2.5-Tokenomics-updates/contracts/interface/dao/node/settings/RocketDAONodeTrustedSettingsProposalsInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAONodeTrustedSettingsProposalsInterface {
    function getCooldown() external view returns(uint256);
    function getVoteBlocks() external view returns(uint256);
    function getVoteDelayBlocks() external view returns(uint256);
    function getExecuteBlocks() external view returns(uint256);
    function getActionBlocks() external view returns(uint256);
}
