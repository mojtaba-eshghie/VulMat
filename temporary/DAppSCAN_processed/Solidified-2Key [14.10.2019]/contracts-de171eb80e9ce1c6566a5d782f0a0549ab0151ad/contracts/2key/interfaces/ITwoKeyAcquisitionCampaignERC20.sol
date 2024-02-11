// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyAcquisitionCampaignERC20.sol

pragma solidity ^0.4.24;

// @author Nikola Madjarevic
// @notice Contract which will act as an interface for only methods we need from AcquisitionCampaign in other contracts
contract ITwoKeyAcquisitionCampaignERC20 {
    address public conversionHandler;
    function buyTokensAndDistributeReferrerRewards(uint256 _maxReferralRewardETHWei, address _converter, uint _conversionId, bool _isConversionFiat) public returns (uint);
    function moveFungibleAsset(address _to, uint256 _amount) public;
    function updateContractorProceeds(uint value) public;
    function sendBackEthWhenConversionCancelled(address _cancelledConverter, uint _conversionAmount) public;
    function buyTokensForModeratorRewards(uint moderatorFee) public;
    function updateReservedAmountOfTokensIfConversionRejectedOrExecuted(uint value) public;
    function refundConverterAndRemoveUnits(address _converter, uint amountOfEther, uint amountOfUnits) external;
    function getStatistics(address ethereum, address plasma) public view returns (uint,uint,uint,uint);
    function getAvailableAndNonReservedTokensAmount() external view returns (uint);
    function getTotalReferrerEarnings(address _referrer, address eth_address) public view returns (uint);
    function getReferrerPlasmaBalance(address _influencer) public view returns (uint);
    function updateReferrerPlasmaBalance(address _influencer, uint _balance) public;
    function getReferrerCut(address me) public view returns (uint256);
}
