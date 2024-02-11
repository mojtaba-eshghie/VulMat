// File: ../sc_datasets/DAppSCAN/consensys-MCDEX_Mai_Protocol_V2/mai-protocol-v2-4b198083ec4ae2d6851e101fc44ea333eaa3cd92/contracts/interface/IPriceFeeder.sol

pragma solidity ^0.5.2;


interface IPriceFeeder {
    function price() external view returns (uint256 lastPrice, uint256 lastTimestamp);
}
