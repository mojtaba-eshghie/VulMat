// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IBridge.sol

pragma solidity 0.5.13;

interface IBridge {
    function requireToPassMessage(address,bytes calldata,uint256) external;
    function messageSender() external returns (address);
}
