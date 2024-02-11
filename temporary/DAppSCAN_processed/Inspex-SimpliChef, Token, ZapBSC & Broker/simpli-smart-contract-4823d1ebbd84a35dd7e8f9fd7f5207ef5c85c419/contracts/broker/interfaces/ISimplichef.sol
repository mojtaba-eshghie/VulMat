// File: ../sc_datasets/DAppSCAN/Inspex-SimpliChef, Token, ZapBSC & Broker/simpli-smart-contract-4823d1ebbd84a35dd7e8f9fd7f5207ef5c85c419/contracts/broker/interfaces/ISimplichef.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISimplichef {
    function add(uint256 _allocPoint, address _want, bool _withUpdate, address _strat) external;
    function set(uint256 _pid, uint256 _allocPoint, bool _withUpdate) external;
    function deposit(uint256 _pid, uint256 _wantAmt) external;
    function depositOnlyBroker(uint256 _pid, uint256 _wantAmt, address beneficiary) external;
    function withdraw(uint256 _pid, uint256 _wantAmt) external;
    function withdrawOnlyBroker(uint256 _pid, uint256 _wantAmt, address beneficiary) external returns (uint256);
    function poolAddress(uint256 pid) external view returns (address);
}
