// File: ../sc_datasets/DAppSCAN/consensys-MCDEX_Mai_Protocol_V2/mai-protocol-v2-4b198083ec4ae2d6851e101fc44ea333eaa3cd92/contracts/interface/IChainlinkFeeder.sol

pragma solidity ^0.5.2;


// see https://github.com/smartcontractkit/chainlink/blob/v0.7.2/evm/contracts/interfaces/AggregatorInterface.sol
interface IChainlinkFeeder {
    function latestAnswer() external view returns (int256);

    function latestTimestamp() external view returns (uint256);
}
