// File: ../sc_datasets/DAppSCAN/Quantstamp-Mainframe/hifi-protocol-72d6bb4b881b1819230101e66783b6b62e369b72/contracts/oracles/UniswapAnchoredViewInterface.sol

/* SPDX-License-Identifier: LGPL-3.0-or-later */
pragma solidity ^0.7.0;

/**
 * @title UniswapAnchoredViewInterface
 * @author Mainframe
 * @notice Interface for accessing the Compound Open Price Feed.
 * https://compound.finance/docs/prices
 */
interface UniswapAnchoredViewInterface {
    /**
     * @notice Get the official price for a symbol.
     * @param symbol The symbol to fetch the price of.
     * @return Price denominated in USD, with 6 decimals.
     */
    function price(string memory symbol) external view returns (uint256);
}
