// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/interfaces/delegation/ILocker.sol

pragma solidity 0.5.16;


interface ILocker {
    function getAndUpdateLockedAmount(address wallet) external returns (uint);
    function getAndUpdateForbiddenForDelegationAmount(address wallet) external returns (uint);
}
