// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit v2/EasyPool-master/contracts/abstract/IAffiliate.sol

pragma solidity ^0.4.24;


/**
 * @title Affiliate Interface 
 */
contract IAffiliate {
    function getSharePerEther(address subscriber) external view returns(uint sharePerEther, bool success);
    function sendRevenueShare(address subscriber) external payable;
}
