// File: ../sc_datasets/DAppSCAN/PeckShield-Hegic_HardCore_Beta/hegic-hardcore-beta-e22e6f67f1ce99e1317fc52fa325b496464a95bd/contracts/BondingCurve/IBondingCurve.sol

pragma solidity 0.8.6;

interface IETHBondingCurve {
    function buy(uint256 tokenAmount) external payable;

    function sell(uint256 tokenAmount) external;
}

interface IErc20BondingCurve {
    function buy(uint256 tokenAmount) external;

    function sell(uint256 tokenAmount) external;
}
