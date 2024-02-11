// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/abstract/IPoolRegistry.sol

pragma solidity ^0.4.24;


/**
 * @title PoolRegistry Interface 
 */
contract IPoolRegistry {
    function register
    (
        address creatorAddress,
        address poolAddress,
        uint poolVersion,
        uint code
    )
        external;
}
