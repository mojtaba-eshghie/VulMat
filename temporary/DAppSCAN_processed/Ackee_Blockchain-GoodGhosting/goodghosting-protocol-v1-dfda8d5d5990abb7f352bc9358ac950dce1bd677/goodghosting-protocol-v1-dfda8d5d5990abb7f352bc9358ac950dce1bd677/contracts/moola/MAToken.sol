// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/moola/MAToken.sol

pragma solidity 0.6.11;

interface MAToken {
    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    function redeem(uint256 _amount) external;

}
