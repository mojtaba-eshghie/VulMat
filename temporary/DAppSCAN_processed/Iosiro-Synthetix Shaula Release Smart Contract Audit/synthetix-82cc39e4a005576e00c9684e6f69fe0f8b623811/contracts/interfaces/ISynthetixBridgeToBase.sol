// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-82cc39e4a005576e00c9684e6f69fe0f8b623811/contracts/interfaces/ISynthetixBridgeToBase.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToBase {
    // invoked by users on L2
    function initiateWithdrawal(uint amount) external;

    // invoked by the xDomain messenger on L2
    function mintSecondaryFromDeposit(address account, uint amount) external;

    // invoked by the xDomain messenger on L2
    function mintSecondaryFromDepositForRewards(uint amount) external;
}
