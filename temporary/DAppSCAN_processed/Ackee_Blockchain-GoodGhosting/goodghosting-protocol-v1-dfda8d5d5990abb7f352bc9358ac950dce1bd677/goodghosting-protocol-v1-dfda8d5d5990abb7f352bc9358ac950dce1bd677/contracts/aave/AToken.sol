// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/aave/AToken.sol

// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.11;

interface AToken {
    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);
}
