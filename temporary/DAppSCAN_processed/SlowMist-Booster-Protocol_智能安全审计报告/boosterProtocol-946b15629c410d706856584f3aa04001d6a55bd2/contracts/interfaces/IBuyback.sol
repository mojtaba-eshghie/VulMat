// File: ../sc_datasets/DAppSCAN/SlowMist-Booster-Protocol_智能安全审计报告/boosterProtocol-946b15629c410d706856584f3aa04001d6a55bd2/contracts/interfaces/IBuyback.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IBuyback {
    function buyback(address _token, uint256 _value) external returns (uint256 value);
}
