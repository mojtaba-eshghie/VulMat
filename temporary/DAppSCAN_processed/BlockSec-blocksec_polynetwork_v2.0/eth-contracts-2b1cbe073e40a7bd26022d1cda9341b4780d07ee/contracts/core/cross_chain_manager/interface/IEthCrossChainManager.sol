// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/core/cross_chain_manager/interface/IEthCrossChainManager.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the EthCrossChainManager contract for business contract like LockProxy to request cross chain transaction
 */
interface IEthCrossChainManager {
    function crossChain(uint64 _toChainId, bytes calldata _toContract, bytes calldata _method, bytes calldata _txData) external returns (bool);
}
