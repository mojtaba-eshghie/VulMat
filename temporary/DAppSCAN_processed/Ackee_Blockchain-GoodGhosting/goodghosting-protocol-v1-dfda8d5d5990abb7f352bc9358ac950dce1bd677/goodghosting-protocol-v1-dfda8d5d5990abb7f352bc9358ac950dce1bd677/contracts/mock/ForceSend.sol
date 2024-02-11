// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-GoodGhosting/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/goodghosting-protocol-v1-dfda8d5d5990abb7f352bc9358ac950dce1bd677/contracts/mock/ForceSend.sol

pragma solidity 0.6.11;

// Used for sending ETH to DAI Unlocked Account on Test Cases (when forking from live network)
contract ForceSend {
    function go(address payable victim) external payable {
        selfdestruct(victim);
    }
}
