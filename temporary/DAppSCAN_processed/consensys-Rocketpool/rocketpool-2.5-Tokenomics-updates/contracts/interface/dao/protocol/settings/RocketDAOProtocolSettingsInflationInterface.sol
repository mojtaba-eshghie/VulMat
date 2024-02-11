// File: ../sc_datasets/DAppSCAN/consensys-Rocketpool/rocketpool-2.5-Tokenomics-updates/contracts/interface/dao/protocol/settings/RocketDAOProtocolSettingsInflationInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAOProtocolSettingsInflationInterface {
    function getInflationIntervalRate() external view returns (uint256);
    function getInflationIntervalBlocks() external view returns (uint256);
    function getInflationIntervalStartBlock() external view returns (uint256);
}
