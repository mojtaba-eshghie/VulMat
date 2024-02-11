// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-hermez/contracts-d52ed73a0c7deaf06fcb0f981e14326f95cd1b78/contracts/hermez/interfaces/AuctionInterface.sol

// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.6.12;

/**
 * @dev Define interface verifier
 */
interface AuctionInterface {
    function canForge(address forger, uint256 blockNumber)
        external
        view
        returns (bool);

    function forge(address forger) external;
}
