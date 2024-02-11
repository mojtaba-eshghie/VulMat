// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IAccessControlEnumerable.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev External interface of AccessControlEnumerable declared to support ERC165 detection.
 */
interface IAccessControlEnumerable {
    function getRoleMember(bytes32 role, uint256 index) external view returns (address);

    function getRoleMemberCount(bytes32 role) external view returns (uint256);
}
