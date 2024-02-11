// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IAlternateReceiverBridge.sol

pragma solidity 0.5.13;

interface IAlternateReceiverBridge {
    function relayTokens(address _sender, address _receiver, uint256 _amount) external;
    function withinLimit(uint256 _amount) external view returns (bool);
}
