// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/core/cross_chain_manager/interface/IUpgradableECCM.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of upgradableECCM to make ECCM be upgradable, the implementation is in UpgradableECCM.sol
 */
interface IUpgradableECCM {
    function pause() external returns (bool);
    function unpause() external returns (bool);
    function paused() external view returns (bool);
    function upgradeToNew(address) external returns (bool);
    function isOwner() external view returns (bool);
    function setChainId(uint64 _newChainId) external returns (bool);
}
