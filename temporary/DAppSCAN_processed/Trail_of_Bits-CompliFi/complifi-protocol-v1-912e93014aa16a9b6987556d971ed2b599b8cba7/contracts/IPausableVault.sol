// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-CompliFi/complifi-protocol-v1-912e93014aa16a9b6987556d971ed2b599b8cba7/contracts/IPausableVault.sol

// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

interface IPausableVault {
    function pause() external;

    function unpause() external;
}
