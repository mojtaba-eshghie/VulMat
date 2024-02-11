// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Generic Lender/yearnV2-generic-lender-strat-979ef2f0e5da39ca59a5907c37ba2064fcd6be82/contracts/Interfaces/GenericLender/IGeneric.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

interface IGeneric {
    //state changing

    function withdraw(uint256 amount) external returns (uint256);

    function emergencyWithdraw(uint256 amount) external;

    function deposit() external;

    function withdrawAll() external returns (bool);

    //view only

    function nav() external view returns (uint256);

    function apr() external view returns (uint256);

    function weightedApr() external view returns (uint256);

    // SWC-Code With No Effects: L24
    function enabled() external view returns (bool);

    function hasAssets() external view returns (bool);

    function aprAfterDeposit(uint256 amount) external view returns (uint256);
}
