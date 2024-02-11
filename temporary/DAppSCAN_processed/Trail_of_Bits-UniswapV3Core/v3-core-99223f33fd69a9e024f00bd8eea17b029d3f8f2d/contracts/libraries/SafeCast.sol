// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-UniswapV3Core/v3-core-99223f33fd69a9e024f00bd8eea17b029d3f8f2d/contracts/libraries/SafeCast.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0;

/// @title Safe down casting methods
/// @notice Contains methods for safely downcasting to smaller types
library SafeCast {
    /// @notice Cast a uint256 to a uint160, revert on overflow
    /// @return z The downcasted integer, now type uint160
    function toUint160(uint256 y) internal pure returns (uint160 z) {
        require((z = uint160(y)) == y);
    }

    /// @notice Cast a int256 to a int128, revert on overflow or underflow
    /// @return z The downcasted integer, now type int128
    function toInt128(int256 y) internal pure returns (int128 z) {
        require((z = int128(y)) == y);
    }

    /// @notice Cast a uint256 to a int256, revert on overflow
    /// @return z The downcasted integer, now type int256
    function toInt256(uint256 y) internal pure returns (int256 z) {
        require(y < 2**255);
        z = int256(y);
    }
}
