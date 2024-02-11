// File: ../sc_datasets/DAppSCAN/openzeppelin-Tally_SafeGuard_Audit/safeguard-b2c63a9dfc4090be13320d999e7c6c1d842625d3/contracts/IRegistry.sol

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IRegistry {
    function register(address safeGuard, uint8 version) external;

    function getSafeGuardCount() external view returns (uint256);

    function getSafeGuard(uint256 index) external returns (address);
}
