// File: ../sc_datasets/DAppSCAN/Coinfabrik-Avalaunch XAVA Protocol Audit/xava-protocol-fd9b97ccd963819a282fa5c21bf0545d180f8797/contracts/interfaces/IAvalaunchSale.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

/**
 * IAvalaunchSale contract.
 * Date created: 3.3.22.
 */
interface IAvalaunchSale {
    function autoParticipate(
        address user,
        uint256 amount,
        uint256 amountXavaToBurn,
        uint256 roundId
    ) external payable;

    function boostParticipation(
        address user,
        uint256 amount,
        uint256 amountXavaToBurn,
        uint256 roundId
    )
    external payable;
}
