// File: ../sc_datasets/DAppSCAN/consensys-MCDEX_Mai_Protocol_V2/mai-protocol-v2-4b198083ec4ae2d6851e101fc44ea333eaa3cd92/contracts/interface/IGlobalConfig.sol

pragma solidity ^0.5.2;

interface IGlobalConfig {
    function withdrawalLockBlockCount() external view returns (uint256);

    function brokerLockBlockCount() external view returns (uint256);
}
