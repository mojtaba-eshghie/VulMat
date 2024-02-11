// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IAccessControl.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControl {
    function hasRole(bytes32 role, address account) external view returns (bool);

    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    function grantRole(bytes32 role, address account) external;

    function revokeRole(bytes32 role, address account) external;

    function renounceRole(bytes32 role, address account) external;
}
