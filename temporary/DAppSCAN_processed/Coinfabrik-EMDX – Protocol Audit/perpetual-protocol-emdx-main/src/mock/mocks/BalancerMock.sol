// File: ../sc_datasets/DAppSCAN/Coinfabrik-EMDX – Protocol Audit/perpetual-protocol-emdx-main/src/mock/mocks/BalancerMock.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

contract BalancerMock {
    constructor() public {}

    function initialize(address perpToken, address cUSDT) external {
        currentTokens.push(perpToken);
        currentTokens.push(cUSDT);
    }

    uint256 private spotPrice = 1;

    function getSpotPrice(address tokenIn, address tokenOut) external view returns (uint256) {
        return spotPrice;
    }

    function mockSetSpotPrice(uint256 price) public {
        spotPrice = price;
    }

    address[] private currentTokens;

    function getCurrentTokens() external view returns (address[] memory) {
        return currentTokens;
    }

    function mockSetCurrentTokens(address[] calldata tokens) external {
        currentTokens = tokens;
    }
}
