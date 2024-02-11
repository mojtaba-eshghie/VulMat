// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/quickswap/IPair.sol

// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.11;

abstract contract IPair {
    function getReserves() virtual external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function balanceOf(address owner) virtual external view returns (uint);

    function approve(address spender, uint value) virtual external returns (bool);

    function totalSupply() virtual external view returns (uint);
}
