// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Vault V2 (Vyper part)/contracts-461ff006f6da63b339819fdb5e76468656d6625c/lending-optimizer/contracts/interfaces/IAmunUser.sol

pragma solidity ^0.6.2;

interface IAmunUser {
    function isAmunUser(address _amunUser) external view returns (bool);
    function isOnlyAmunUserActive() external view returns (bool);
}
