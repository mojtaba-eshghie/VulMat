// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyDonationLogicHandler.sol

pragma solidity ^0.4.0;

contract ITwoKeyDonationLogicHandler {
    function getReferrers(address customer) public view returns (address[]);

    function updateRefchainRewards(
        uint256 _maxReferralRewardETHWei,
        address _converter,
        uint _conversionId,
        uint totalBounty2keys
    )
    public;

    function getReferrerPlasmaTotalEarnings(address _referrer) public view returns (uint);
}
