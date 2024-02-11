// File: ../sc_datasets/DAppSCAN/Quantstamp-NAOS-Formation Updates/NAOS-Formation-c1404ec0f5de6f80189b528acf5f0923ff8d4e6e/contracts/interfaces/IAlpacaPool.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

interface IAlpacaPool {
    function deposit(address, uint256, uint256) external;

    function withdraw(address, uint256, uint256) external;

    function harvest(uint256) external;

    function userInfo(uint256, address) external view returns (uint256, uint256, uint256, address);
}
