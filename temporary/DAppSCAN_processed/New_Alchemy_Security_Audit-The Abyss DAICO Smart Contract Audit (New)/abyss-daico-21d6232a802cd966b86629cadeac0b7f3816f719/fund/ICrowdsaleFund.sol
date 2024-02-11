// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/fund/ICrowdsaleFund.sol

pragma solidity ^0.4.21;

/**
 * @title ICrowdsaleFund
 * @dev Fund methods used by crowdsale contract
 */
interface ICrowdsaleFund {
    /**
    * @dev Function accepts user`s contributed ether and logs contribution
    * @param contributor Contributor wallet address.
    */
    function processContribution(address contributor) external payable;
    /**
    * @dev Function is called on the end of successful crowdsale
    */
    function onCrowdsaleEnd() external;
    /**
    * @dev Function is called if crowdsale failed to reach soft cap
    */
    function enableCrowdsaleRefund() external;
}
