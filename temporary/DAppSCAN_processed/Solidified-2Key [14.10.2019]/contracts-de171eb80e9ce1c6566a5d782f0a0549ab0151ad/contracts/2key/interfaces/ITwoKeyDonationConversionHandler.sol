// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyDonationConversionHandler.sol

pragma solidity ^0.4.0;

contract ITwoKeyDonationConversionHandler {
    function supportForCreateConversion(
        address _converterAddress,
        uint _conversionAmount,
        uint _maxReferralRewardETHWei,
        bool _isKYCRequired
    )
    public
    returns (uint);

    function executeConversion(
        uint _conversionId
    )
    public;

    function getAmountConverterSpent(
        address converter
    )
    public
    view
    returns (uint);

    function getStateForConverter(
        address _converter
    )
    external
    view
    returns (bytes32);

}
