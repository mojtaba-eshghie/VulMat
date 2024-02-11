// File: ../sc_datasets/DAppSCAN/PeckShield-Pandora/smart-contract-d0aa3193b8ffcd7fc84481c30e16283837319719/contracts/0.6.x/contracts/interfaces/ITradingPool.sol

//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0;
interface ITradingPool {
    function enter(
        address account,
        address input,
        address output,
        uint256 amount
    ) external returns (bool);
}
