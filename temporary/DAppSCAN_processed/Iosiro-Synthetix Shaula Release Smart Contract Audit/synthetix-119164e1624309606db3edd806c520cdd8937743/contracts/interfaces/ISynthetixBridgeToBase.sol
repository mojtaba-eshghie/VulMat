// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-119164e1624309606db3edd806c520cdd8937743/contracts/interfaces/ISynthetixBridgeToBase.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToBase {
    // invoked by users on L2
    function initiateWithdrawal(uint amount) external;

    // invoked by the xDomain messenger on L2
    function completeDeposit(address account, uint amount) external;

    // invoked by the xDomain messenger on L2
    function completeRewardDeposit(uint amount) external;
}
