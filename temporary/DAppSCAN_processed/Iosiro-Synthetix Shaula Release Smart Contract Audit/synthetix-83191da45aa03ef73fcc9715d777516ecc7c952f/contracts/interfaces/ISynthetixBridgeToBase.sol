// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-83191da45aa03ef73fcc9715d777516ecc7c952f/contracts/interfaces/ISynthetixBridgeToBase.sol

pragma solidity >=0.4.24;


interface ISynthetixBridgeToBase {
    // invoked by users on L2
    function initiateWithdrawal(uint amount) external;

    // invoked by the xDomain messenger on L2
    function mintSecondaryFromDeposit(address account, uint amount) external;

    // invoked by the xDomain messenger on L2
    function mintSecondaryFromDepositForRewards(uint amount) external;
}
