// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/interfaces/INodesFunctionality.sol

pragma solidity 0.5.16;

interface INodesFunctionality {
    function createNode(address from, bytes calldata data) external returns (uint);
    function initExit(address from, uint nodeIndex) external returns (bool);
    function completeExit(address from, uint nodeIndex) external returns (bool);
    function removeNode(address from, uint nodeIndex) external;
    function removeNodeByRoot(uint nodeIndex) external;
}
