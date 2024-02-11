// File: ../sc_datasets/DAppSCAN/PeckShield-DarkCrypto/darkcrypto-contracts-fee5be8d36459aebed2b84e6493875b3dc0366fd/contracts/interfaces/ITreasury.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface ITreasury {
    function epoch() external view returns (uint256);

    function nextEpochPoint() external view returns (uint256);

    function getDarkPrice() external view returns (uint256);

    function buyBonds(uint256 amount, uint256 targetPrice) external;

    function redeemBonds(uint256 amount, uint256 targetPrice) external;
}
