// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-50c8f4e037f6bf578d62bd752516b17237b55811/contracts/interfaces/ISchainsFunctionality.sol

pragma solidity ^0.5.3;

interface ISchainsFunctionality {
    function addSchain(address from, uint value, bytes calldata data) external;
    function deleteSchain(address from, string calldata name) external;
    function deleteSchainByRoot(string calldata name) external;
    function rotateNode(uint nodeIndex, bytes32 schainId) external;
}
