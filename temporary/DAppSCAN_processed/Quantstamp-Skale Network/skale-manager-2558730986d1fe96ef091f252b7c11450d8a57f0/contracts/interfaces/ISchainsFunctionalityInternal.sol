// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/interfaces/ISchainsFunctionalityInternal.sol

pragma solidity ^0.5.0;

interface ISchainsFunctionalityInternal {
    function getNodesDataFromTypeOfSchain(uint typeOfSchain) external view returns (uint, uint8);
    function createGroupForSchain(
        string calldata schainName,
        bytes32 schainId,
        uint numberOfNodes,
        uint8 partOfNode) external;
    function findSchainAtSchainsForNode(uint nodeIndex, bytes32 schainId) external view returns (uint);
    function deleteGroup(bytes32 groupIndex) external;
    function selectNodeToGroup(bytes32 groupIndex) external;
    function removeNodeFromSchain(uint nodeIndex, bytes32 groupHash) external;
    function removeNodeFromExceptions(bytes32 groupHash, uint nodeIndex) external;
    function excludeNodeFromSchain(uint nodeIndex, bytes32 groupHash) external;
    function isEnoughNodes(bytes32 groupIndex) external view returns (uint[] memory);
}
