// File: ../sc_datasets/DAppSCAN/Quantstamp-Merit Circle/merit-liquidity-mining-f558820be3da400638eb3a978245cdb126367ac4/contracts/interfaces/ITimeLockPool.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
interface ITimeLockPool {
    function deposit(uint256 _amount, uint256 _duration, address _receiver) external;
}
