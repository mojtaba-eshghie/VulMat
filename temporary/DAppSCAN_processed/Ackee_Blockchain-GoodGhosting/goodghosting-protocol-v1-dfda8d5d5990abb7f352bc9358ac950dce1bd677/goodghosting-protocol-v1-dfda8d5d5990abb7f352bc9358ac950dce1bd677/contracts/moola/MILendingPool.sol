// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/moola/MILendingPool.sol

pragma solidity 0.6.11;

interface MILendingPool {
    function deposit( address _reserve, uint256 _amount, uint16 _referralCode) external;
    //see: https://github.com/aave/aave-protocol/blob/1ff8418eb5c73ce233ac44bfb7541d07828b273f/contracts/tokenization/AToken.sol#L218
    function withdraw(address asset, uint amount, address to) external;
}
