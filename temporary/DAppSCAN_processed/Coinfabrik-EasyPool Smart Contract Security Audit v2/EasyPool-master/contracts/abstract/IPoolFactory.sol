// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit v2/EasyPool-master/contracts/abstract/IPoolFactory.sol

pragma solidity ^0.4.24;


/**
 * @title PoolFactory Interface 
 */
contract IPoolFactory {
    function deploy
    (
        uint maxBalance,
        uint minContribution,
        uint maxContribution,
        uint ctorFeePerEther,        
        address creatorAddress,
        address presaleAddress,
        address feeManagerAddr,
        address[] whitelist,
        address[] adminis
    )
        external
        returns (address poolAddress, uint poolVersion);
}
