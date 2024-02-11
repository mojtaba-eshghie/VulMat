// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/mock/MockAirnodeEndpointFeeRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract MockAirnodeEndpointPriceRegistry {
    string public DENOMINATION; // solhint-disable-line var-name-mixedcase
    uint256 public DECIMALS; // solhint-disable-line var-name-mixedcase
    uint256 public PRICING_INTERVAL; // solhint-disable-line var-name-mixedcase

    constructor(
        string memory denomination,
        uint256 decimals,
        uint256 pricingInterval
    ) {
        DENOMINATION = denomination;
        DECIMALS = decimals;
        PRICING_INTERVAL = pricingInterval;
    }
}
