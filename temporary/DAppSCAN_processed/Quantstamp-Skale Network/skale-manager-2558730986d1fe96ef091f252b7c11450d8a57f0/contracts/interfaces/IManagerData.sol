// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/interfaces/IManagerData.sol

pragma solidity 0.5.16;

interface IManagerData {
    function setMinersCap(uint newMinersCap) external;
    function setStageTimeAndStageNodes(uint newStageNodes) external;
    function minersCap() external view returns (uint);
    function startTime() external view returns (uint32);
    function stageTime() external view returns (uint32);
    function stageNodes() external view returns (uint);
}
