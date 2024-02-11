// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-88mph/88mph-contracts-76cd9d1fc45e65f5d0f686621fe6af85c40aa140/contracts/moneymarkets/compound/imports/IComptroller.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

// Compound finance Comptroller interface
// Documentation: https://compound.finance/docs/comptroller
interface IComptroller {
    function claimComp(address holder) external;

    function getCompAddress() external view returns (address);
}
