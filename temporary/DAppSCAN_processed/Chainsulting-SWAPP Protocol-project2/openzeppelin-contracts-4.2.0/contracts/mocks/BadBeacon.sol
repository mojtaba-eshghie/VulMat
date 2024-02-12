// File: ../sc_datasets/DAppSCAN/Chainsulting-SWAPP Protocol-project2/openzeppelin-contracts-4.2.0/contracts/mocks/BadBeacon.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract BadBeaconNoImpl {}

contract BadBeaconNotContract {
    function implementation() external pure returns (address) {
        return address(0x1);
    }
}