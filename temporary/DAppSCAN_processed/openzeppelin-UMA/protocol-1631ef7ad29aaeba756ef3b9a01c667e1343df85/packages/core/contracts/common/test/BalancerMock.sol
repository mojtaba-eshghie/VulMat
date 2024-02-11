// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/interfaces/Balancer.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @title Interface for Balancer.
 * @dev This only contains the methods/events that we use in our contracts or offchain infrastructure.
 */
abstract contract Balancer {
    function getSpotPriceSansFee(address tokenIn, address tokenOut) external view virtual returns (uint256 spotPrice);
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/test/BalancerMock.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @title Balancer Mock
 */
contract BalancerMock is Balancer {
    uint256 price = 0;

    // these params arent used in the mock, but this is to maintain compatibility with balancer API
    function getSpotPriceSansFee(address tokenIn, address tokenOut)
        external
        view
        virtual
        override
        returns (uint256 spotPrice)
    {
        return price;
    }

    // this is not a balancer call, but for testing for changing price.
    function setPrice(uint256 newPrice) external {
        price = newPrice;
    }
}
