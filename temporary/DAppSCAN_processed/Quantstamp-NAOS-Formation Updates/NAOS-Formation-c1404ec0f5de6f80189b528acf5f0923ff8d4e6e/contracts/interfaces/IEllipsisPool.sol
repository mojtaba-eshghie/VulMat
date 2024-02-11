// File: ../sc_datasets/DAppSCAN/Quantstamp-NAOS-Formation Updates/NAOS-Formation-c1404ec0f5de6f80189b528acf5f0923ff8d4e6e/contracts/interfaces/IEllipsisPool.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

interface IEllipsisPool {
    function deposit(uint256, uint256) external;

    function withdraw(uint256, uint256) external;

    function userInfo(uint256, address) external view returns (uint256, uint256);
}
