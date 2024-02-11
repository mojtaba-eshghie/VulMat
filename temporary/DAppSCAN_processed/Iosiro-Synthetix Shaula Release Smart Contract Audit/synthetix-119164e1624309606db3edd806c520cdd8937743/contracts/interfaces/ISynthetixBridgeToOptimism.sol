// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-119164e1624309606db3edd806c520cdd8937743/contracts/interfaces/ISynthetixBridgeToOptimism.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToOptimism {
    // invoked by users on L1
    function initiateDeposit(uint amount) external;

    // invoked by the relayer on L1
    function completeWithdrawal(address account, uint amount) external;
}
