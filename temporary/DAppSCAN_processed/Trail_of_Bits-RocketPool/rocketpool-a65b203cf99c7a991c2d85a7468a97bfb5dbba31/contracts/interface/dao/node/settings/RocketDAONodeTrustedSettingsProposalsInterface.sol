// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/dao/node/settings/RocketDAONodeTrustedSettingsProposalsInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAONodeTrustedSettingsProposalsInterface {
    function getCooldownTime() external view returns(uint256);
    function getVoteTime() external view returns(uint256);
    function getVoteDelayTime() external view returns(uint256);
    function getExecuteTime() external view returns(uint256);
    function getActionTime() external view returns(uint256);
}
