// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyAcquisitionLogicHandler.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 1/15/19
 */
contract ITwoKeyAcquisitionLogicHandler {
    function checkIsCampaignActive() public view returns (bool);
    bool public IS_CAMPAIGN_ACTIVE;
    function canConversionBeCreated(address converter, uint amountWillingToSpend, bool isFiat) public view returns (bool);
    function getEstimatedTokenAmount(uint conversionAmountETHWei, bool isFiatConversion) public view returns (uint, uint);

    function setTwoKeyAcquisitionCampaignContract(
        address _acquisitionCampaignAddress,
        address twoKeySingletoneRegistry,
        address _twoKeyConversionHandler) public;

    function getReferrers(address customer, address acquisitionCampaignContract) public view returns (address[]);
    function updateRefchainRewards(uint256 _maxReferralRewardETHWei, address _converter, uint _conversionId, uint totalBounty2keys) public;
    function getReferrerPlasmaTotalEarnings(address _referrer) public view returns (uint);
}
