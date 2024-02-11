// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Vault V2 (Vyper part)/contracts-461ff006f6da63b339819fdb5e76468656d6625c/index-tokens/Abstract/InterfaceCalculator.sol

pragma solidity ^0.5.0;


interface InterfaceCalculator {
    function getTokensCreatedByCash(
        uint256 mintingPrice,
        uint256 cash,
        uint256 gasFee
    ) external view returns (uint256 tokensCreated);

    function getCashCreatedByTokens(
        uint256 burningPrice,
        uint256 elapsedTime,
        uint256 tokens,
        uint256 gasFee
    ) external view returns (uint256 stablecoinRedeemed);

    function removeCurrentMintingFeeFromCash(uint256 _cash)
        external
        view
        returns (uint256 cashAfterFee);

    function removeMintingFeeFromCash(
        uint256 _cash,
        uint256 _mintingFee,
        uint256 _minimumMintingFee
    ) external pure returns (uint256 cashAfterFee);
}
