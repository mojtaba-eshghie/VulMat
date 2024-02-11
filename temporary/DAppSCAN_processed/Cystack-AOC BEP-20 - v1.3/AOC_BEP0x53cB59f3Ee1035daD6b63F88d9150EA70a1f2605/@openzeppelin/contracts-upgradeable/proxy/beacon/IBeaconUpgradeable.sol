// File: ../sc_datasets/DAppSCAN/Cystack-AOC BEP-20 - v1.3/AOC_BEP0x53cB59f3Ee1035daD6b63F88d9150EA70a1f2605/@openzeppelin/contracts-upgradeable/proxy/beacon/IBeaconUpgradeable.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (proxy/beacon/IBeacon.sol)

pragma solidity ^0.8.0;

/**
 * @dev This is the interface that {BeaconProxy} expects of its beacon.
 */
interface IBeaconUpgradeable {
    /**
     * @dev Must return an address that can be used as a delegate call target.
     *
     * {BeaconProxy} will check that this address is a contract.
     */
    function implementation() external view returns (address);
}
