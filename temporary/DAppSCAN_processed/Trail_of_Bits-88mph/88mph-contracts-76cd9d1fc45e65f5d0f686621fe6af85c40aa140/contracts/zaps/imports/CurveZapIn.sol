// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-88mph/88mph-contracts-76cd9d1fc45e65f5d0f686621fe6af85c40aa140/contracts/zaps/imports/CurveZapIn.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

interface CurveZapIn {
    /**
        @notice This function adds liquidity to a Curve pool with ETH or ERC20 tokens
        @param toWhomToIssue The address to return the Curve LP tokens to
        @param fromToken The ERC20 token used for investment (address(0x00) if ether)
        @param swapAddress Curve swap address for the pool
        @param incomingTokenQty The amount of fromToken to invest
        @param minPoolTokens The minimum acceptable quantity of tokens to receive. Reverts otherwise
        @return crvTokensBought Amount of Curve LP tokens received
    */
    function ZapIn(
        address toWhomToIssue,
        address fromToken,
        address swapAddress,
        uint256 incomingTokenQty,
        uint256 minPoolTokens
    ) external payable returns (uint256 crvTokensBought);
}
