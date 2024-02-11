// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-88mph/88mph-contracts-76cd9d1fc45e65f5d0f686621fe6af85c40aa140/contracts/rewards/dumpers/imports/Curve.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

interface ICurveFi {
    function remove_liquidity_imbalance(
        uint256[2] calldata amounts,
        uint256 max_burn_amount
    ) external;

    function remove_liquidity_imbalance(
        uint256[3] calldata amounts,
        uint256 max_burn_amount
    ) external;

    function remove_liquidity_imbalance(
        uint256[4] calldata amounts,
        uint256 max_burn_amount
    ) external;

    function remove_liquidity_imbalance(
        uint256[5] calldata amounts,
        uint256 max_burn_amount
    ) external;

    function remove_liquidity(uint256 _amount, uint256[2] calldata amounts)
        external;

    function remove_liquidity(uint256 _amount, uint256[3] calldata amounts)
        external;

    function remove_liquidity(uint256 _amount, uint256[4] calldata amounts)
        external;

    function remove_liquidity(uint256 _amount, uint256[5] calldata amounts)
        external;
}

interface Zap {
    function remove_liquidity_one_coin(
        uint256,
        int128,
        uint256
    ) external;
}
