// File: ../sc_datasets/DAppSCAN/SlowMist-Booster-Protocol_智能安全审计报告/boosterProtocol-946b15629c410d706856584f3aa04001d6a55bd2/interfaces/IErc20InterfaceETH.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IErc20InterfaceETH {

    /*** User Interface ***/
    function underlying() external view returns (address);

    function mint() external payable;
    function redeem(uint redeemTokens) external returns (uint);
    function redeemUnderlying(uint redeemAmount) external returns (uint);
    function borrow(uint borrowAmount) external returns (uint);
    function repayBorrow() external payable;

    function isNativeToken() external pure returns (bool);
}
