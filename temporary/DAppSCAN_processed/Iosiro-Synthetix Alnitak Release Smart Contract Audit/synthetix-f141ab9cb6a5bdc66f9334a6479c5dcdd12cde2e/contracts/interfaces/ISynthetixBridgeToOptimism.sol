// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-f141ab9cb6a5bdc66f9334a6479c5dcdd12cde2e/contracts/interfaces/ISynthetixBridgeToOptimism.sol

pragma solidity >=0.4.24;
pragma experimental ABIEncoderV2;

interface ISynthetixBridgeToOptimism {
    function migrateEscrow(uint256[][] calldata entryIDs) external;

    function depositReward(uint amount) external;

    function depositAndMigrateEscrow(uint256 depositAmount, uint256[][] calldata entryIDs) external;
}
