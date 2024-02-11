// File: ../sc_datasets/DAppSCAN/Byterocket-Invictus Capital Fund Contract[01.27.2022]/TransparentUpgradeableProxy0x04Fd86C321E53D6D0070d30eAEFD1d93790EA3d2/@openzeppelin/contracts/proxy/beacon/IBeacon.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev This is the interface that {BeaconProxy} expects of its beacon.
 */
interface IBeacon {
    /**
     * @dev Must return an address that can be used as a delegate call target.
     *
     * {BeaconProxy} will check that this address is a contract.
     */
    function implementation() external view returns (address);
}
