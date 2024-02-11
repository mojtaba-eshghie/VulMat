// File: ../sc_datasets/DAppSCAN/Quantstamp-Vault.Inc/vault-tec-core-a0cd3ec5612da2dcdaa9747eaa49d6ceaae77d42/contracts/interfaces/ITimeLockPool.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

interface ITimeLockPool {
    function deposit(uint256 _amount, uint256 _duration, address _receiver) external;
}
