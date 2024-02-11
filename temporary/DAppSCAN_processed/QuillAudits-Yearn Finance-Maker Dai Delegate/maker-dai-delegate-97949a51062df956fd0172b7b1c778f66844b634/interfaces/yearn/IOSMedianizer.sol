// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Maker Dai Delegate/maker-dai-delegate-97949a51062df956fd0172b7b1c778f66844b634/interfaces/yearn/IOSMedianizer.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface IOSMedianizer {
    function foresight() external view returns (uint256 price, bool osm);

    function read() external view returns (uint256 price, bool osm);
}
