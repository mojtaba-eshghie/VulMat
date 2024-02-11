// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/quickswap/IStake.sol

// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.11;

abstract contract IStake {
function stake(uint256 amount) public virtual;

function exit()  public virtual;
}
