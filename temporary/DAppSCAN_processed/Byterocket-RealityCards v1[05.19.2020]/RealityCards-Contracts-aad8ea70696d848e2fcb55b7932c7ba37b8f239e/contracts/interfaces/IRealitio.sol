// File: ../sc_datasets/DAppSCAN/Byterocket-RealityCards v1[05.19.2020]/RealityCards-Contracts-aad8ea70696d848e2fcb55b7932c7ba37b8f239e/contracts/interfaces/IRealitio.sol

pragma solidity 0.5.13;

/// @title Realit.io contract interface
interface IRealitio 
{
    function askQuestion(uint256 template_id, string calldata question, address arbitrator, uint32 timeout, uint32 opening_ts, uint256 nonce) external payable returns (bytes32);
    function resultFor(bytes32 question_id) external view returns (bytes32);
    function isFinalized(bytes32 question_id) external view returns (bool);
}
