// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-82cc39e4a005576e00c9684e6f69fe0f8b623811/contracts/interfaces/ISynthetixBridgeToOptimism.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToOptimism {
    // invoked by users on L1
    function deposit(uint amount) external;

    // invoked by the relayer on L1
    function completeWithdrawal(address account, uint amount) external;
}
