// File: ../sc_datasets/DAppSCAN/QuillAudits-PieDAO-ExperiPie/PieVaults-facf3c246d9c43f5b1e0bad7dc2b0a9a2a2393c5/contracts/interfaces/IAaveLendingPool.sol

// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.7.1;

interface IAaveLendingPool {
    function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external;
    function core() external view returns(address);
}
