// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-CompliFi/complifi-protocol-v1-912e93014aa16a9b6987556d971ed2b599b8cba7/contracts/IFeeLogger.sol

// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

interface IFeeLogger {
    function log(
        address _liquidityProvider,
        address _collateral,
        uint256 _protocolFee,
        address _author
    ) external;
}
