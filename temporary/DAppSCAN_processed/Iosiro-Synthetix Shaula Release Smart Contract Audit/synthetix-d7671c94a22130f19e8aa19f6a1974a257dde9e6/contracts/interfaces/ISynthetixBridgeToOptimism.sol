// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-d7671c94a22130f19e8aa19f6a1974a257dde9e6/contracts/interfaces/ISynthetixBridgeToOptimism.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToOptimism {
    // invoked by users on L1
    function initiateDeposit(uint amount) external;

    // invoked by the relayer on L1
    function completeWithdrawal(address account, uint amount) external;
}
