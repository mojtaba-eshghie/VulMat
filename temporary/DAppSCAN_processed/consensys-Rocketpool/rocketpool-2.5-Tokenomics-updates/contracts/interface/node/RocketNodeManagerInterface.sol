// File: ../sc_datasets/DAppSCAN/consensys-Rocketpool/rocketpool-2.5-Tokenomics-updates/contracts/interface/node/RocketNodeManagerInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketNodeManagerInterface {
    function getNodeCount() external view returns (uint256);
    function getNodeAt(uint256 _index) external view returns (address);
    function getNodeExists(address _nodeAddress) external view returns (bool);
    function getNodeWithdrawalAddress(address _nodeAddress) external view returns (address);
    function getNodeTimezoneLocation(address _nodeAddress) external view returns (string memory);
    function registerNode(string calldata _timezoneLocation) external;
    function setWithdrawalAddress(address _withdrawalAddress) external;
    function setTimezoneLocation(string calldata _timezoneLocation) external;
}
