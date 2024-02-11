// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/interfaces/ISchainsFunctionality.sol

pragma solidity 0.5.16;

interface ISchainsFunctionality {
    function addSchain(address from, uint value, bytes calldata data) external;
    function deleteSchain(address from, string calldata name) external;
    function deleteSchainByRoot(string calldata name) external;
    function rotateNode(uint nodeIndex, bytes32 schainId) external returns (uint);
    function exitFromSchain(uint nodeIndex) external returns (bool);
}
