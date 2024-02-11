// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyConversionHandler.sol

pragma solidity ^0.4.24;

contract ITwoKeyConversionHandler {

    bool public isFiatConversionAutomaticallyApproved;

    function supportForCreateConversion(
        address _contractor,
        address _converterAddress,
        uint256 _conversionAmount,
        uint256 _maxReferralRewardETHWei,
        uint256 baseTokensForConverterUnits,
        uint256 bonusTokensForConverterUnits,
        bool isConversionFiat,
        bool _isAnonymous,
        bool _isKYCRequired
    )
    public
    returns (uint);

    function executeConversion(
        uint _conversionId
    )
    public;


    function getConverterConversionIds(
        address _converter
    )
    external
    view
    returns (uint[]);


    function getConverterPurchasesStats(
        address _converter
    )
    public
    view
    returns (uint,uint,uint);


    function getStateForConverter(
        address _converter
    )
    public
    view
    returns (bytes32);


}
