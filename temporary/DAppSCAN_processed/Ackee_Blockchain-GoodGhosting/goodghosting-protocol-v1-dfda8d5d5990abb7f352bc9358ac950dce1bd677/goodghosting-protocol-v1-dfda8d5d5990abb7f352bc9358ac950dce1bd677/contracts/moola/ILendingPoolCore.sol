// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/moola/ILendingPoolCore.sol

pragma solidity 0.6.11;

interface ILendingPoolCore {
    function getReserveATokenAddress(address _reserve) external returns (address);
}
