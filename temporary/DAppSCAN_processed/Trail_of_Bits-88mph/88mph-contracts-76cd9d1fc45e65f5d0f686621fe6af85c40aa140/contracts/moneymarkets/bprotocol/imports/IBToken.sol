// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-88mph/88mph-contracts-76cd9d1fc45e65f5d0f686621fe6af85c40aa140/contracts/moneymarkets/bprotocol/imports/IBToken.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

// B.Protocol bToken interface
interface IBToken {
    function mint(uint256 mintAmount) external returns (uint256);

    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function exchangeRateCurrent() external returns (uint256);
}
