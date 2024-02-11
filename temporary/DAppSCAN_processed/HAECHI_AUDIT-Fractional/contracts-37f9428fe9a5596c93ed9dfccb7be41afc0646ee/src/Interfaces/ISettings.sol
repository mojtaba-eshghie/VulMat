// File: ../sc_datasets/DAppSCAN/HAECHI_AUDIT-Fractional/contracts-37f9428fe9a5596c93ed9dfccb7be41afc0646ee/src/Interfaces/ISettings.sol

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISettings {

    function maxAuctionLength() external returns(uint256);

    function minAuctionLength() external returns(uint256);

    function maxCuratorFee() external returns(uint256);

    function governanceFee() external returns(uint256);

    function minBidIncrease() external returns(uint256);

    function maxReserveFactor() external returns(uint256);

    function minReserveFactor() external returns(uint256);

    function feeReceiver() external returns(address payable);

    function allowedNFTs(address) external returns(bool);

}
