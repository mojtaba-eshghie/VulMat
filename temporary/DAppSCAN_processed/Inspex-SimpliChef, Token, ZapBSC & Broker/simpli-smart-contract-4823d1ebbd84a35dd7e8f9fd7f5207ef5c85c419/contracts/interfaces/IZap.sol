// File: ../sc_datasets/DAppSCAN/Inspex-SimpliChef, Token, ZapBSC & Broker/simpli-smart-contract-4823d1ebbd84a35dd7e8f9fd7f5207ef5c85c419/contracts/interfaces/IZap.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IZap {
    function zapOut(address _from, uint amount) external;
    function zapIn(address _to) external payable;
    function zapInToken(address _from, uint amount, address _to) external;
}
