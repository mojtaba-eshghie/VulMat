// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-eb36644a2d8db32c92cc4df936069db8836d0233/contracts/interfaces/ISynthetixBridgeToOptimism.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToOptimism {
    // invoked by users on L1
    function initiateDeposit(uint amount) external;

    // invoked by the relayer on L1
    function completeWithdrawal(address account, uint amount) external;
}
