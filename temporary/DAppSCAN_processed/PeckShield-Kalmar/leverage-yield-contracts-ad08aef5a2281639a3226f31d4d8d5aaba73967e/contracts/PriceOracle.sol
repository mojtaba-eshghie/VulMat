// File: ../sc_datasets/DAppSCAN/PeckShield-Kalmar/leverage-yield-contracts-ad08aef5a2281639a3226f31d4d8d5aaba73967e/contracts/PriceOracle.sol

pragma solidity 0.5.16;

interface PriceOracle {
    /// @dev Return the wad price of token0/token1, multiplied by 1e18
    /// NOTE: (if you have 1 token0 how much you can sell it for token1)
    function getPrice(address token0, address token1)
        external view
        returns (uint256 price, uint256 lastUpdate);
}
