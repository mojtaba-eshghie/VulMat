// File: ../sc_datasets/DAppSCAN/Coinfabrik-Avalaunch XAVA Protocol Audit/xava-protocol-fd9b97ccd963819a282fa5c21bf0545d180f8797/contracts/interfaces/ICollateral.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

interface ICollateral {
    function saleAutoBuyers(address user, address sale) external view returns (bool);
    function depositCollateral() external payable;
    function withdrawCollateral() external payable;
    function totalBalance() external view returns (uint256);
}
