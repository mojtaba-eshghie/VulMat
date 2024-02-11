// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/ISimpleCrowdsale.sol

pragma solidity ^0.4.21;


interface ISimpleCrowdsale {
    function getSoftCap() external view returns(uint256);
    function isContributorInLists(address contributorAddress) external view returns(bool);
    function processReservationFundContribution(
        address contributor,
        uint256 tokenAmount,
        uint256 tokenBonusAmount
    ) external payable;
}
