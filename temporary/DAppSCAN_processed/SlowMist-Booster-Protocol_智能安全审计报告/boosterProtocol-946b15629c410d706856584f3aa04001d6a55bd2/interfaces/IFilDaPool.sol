// File: ../sc_datasets/DAppSCAN/SlowMist-Booster-Protocol_智能安全审计报告/boosterProtocol-946b15629c410d706856584f3aa04001d6a55bd2/interfaces/IFilDaPool.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IFilDaPool {

    // 查询各种池子信息
    function claimComp(address holder) external;
    function claimComp(address holder, address[] memory cTokens) external;
    function claimComp(address[] memory holders, address[] memory cTokens, bool borrowers, bool suppliers) external;
}
