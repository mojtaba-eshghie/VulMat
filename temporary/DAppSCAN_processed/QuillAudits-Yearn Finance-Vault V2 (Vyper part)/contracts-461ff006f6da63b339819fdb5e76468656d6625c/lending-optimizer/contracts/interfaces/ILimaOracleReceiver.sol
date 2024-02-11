// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Vault V2 (Vyper part)/contracts-461ff006f6da63b339819fdb5e76468656d6625c/lending-optimizer/contracts/interfaces/ILimaOracleReceiver.sol

pragma solidity ^0.6.6;

interface ILimaOracleReceiver {
    function receiveOracleData(bytes32 _requestId, bytes32 _data) external;
}
