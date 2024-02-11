// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/interfaces/Uniswap.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @title Interface for Uniswap v2.
 * @dev This only contains the methods/events that we use in our contracts or offchain infrastructure.
 */
abstract contract Uniswap {
    // Called after every swap showing the new uniswap "price" for this token pair.
    event Sync(uint112 reserve0, uint112 reserve1);
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/test/UniswapMock.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @title Uniswap v2 Mock that allows manual price injection.
 */
contract UniswapMock is Uniswap {
    function setPrice(uint112 reserve0, uint112 reserve1) external {
        emit Sync(reserve0, reserve1);
    }
}
