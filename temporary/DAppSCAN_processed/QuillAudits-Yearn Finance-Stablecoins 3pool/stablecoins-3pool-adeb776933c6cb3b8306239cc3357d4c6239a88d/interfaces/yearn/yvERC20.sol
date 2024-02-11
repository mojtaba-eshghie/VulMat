// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Stablecoins 3pool/stablecoins-3pool-adeb776933c6cb3b8306239cc3357d4c6239a88d/interfaces/yearn/yvERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

interface yvERC20 {
    function deposit(uint) external;
    function withdraw(uint) external;
    function getPricePerFullShare() external view returns (uint);
}
