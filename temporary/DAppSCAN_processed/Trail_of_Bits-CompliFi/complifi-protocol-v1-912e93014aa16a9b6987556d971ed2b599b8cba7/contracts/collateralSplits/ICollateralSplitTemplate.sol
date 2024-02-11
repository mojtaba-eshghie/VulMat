// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-CompliFi/complifi-protocol-v1-912e93014aa16a9b6987556d971ed2b599b8cba7/contracts/collateralSplits/ICollateralSplitTemplate.sol

// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

interface ICollateralSplitTemplate {
    function splitNominalValue(int256 _normalizedValue)
        external
        pure
        returns (int256);

    function normalize(int256 _u_0, int256 _u_T) external pure returns (int256);

    function range(int256 _split) external returns (uint256);
}
