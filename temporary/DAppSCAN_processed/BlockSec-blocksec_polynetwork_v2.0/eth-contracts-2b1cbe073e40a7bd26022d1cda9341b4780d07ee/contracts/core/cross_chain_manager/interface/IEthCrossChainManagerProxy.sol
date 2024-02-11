// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/core/cross_chain_manager/interface/IEthCrossChainManagerProxy.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the EthCrossChainManagerProxy for business contract like LockProxy to obtain the reliable EthCrossChainManager contract hash.
 */
interface IEthCrossChainManagerProxy {
    function getEthCrossChainManager() external view returns (address);
}
