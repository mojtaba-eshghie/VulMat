// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/lib/UInt256Lib.sol

pragma solidity 0.4.24;


/**
 * @title Various utilities useful for uint256.
 */
library UInt256Lib {

    uint256 private constant MAX_INT256 = ~(uint256(1) << 255);

    /**
     * @dev Safely converts a uint256 to an int256.
     */
    function toInt256Safe(uint256 a)
        internal
        pure
        returns (int256)
    {
        require(a <= MAX_INT256);
        return int256(a);
    }
}
