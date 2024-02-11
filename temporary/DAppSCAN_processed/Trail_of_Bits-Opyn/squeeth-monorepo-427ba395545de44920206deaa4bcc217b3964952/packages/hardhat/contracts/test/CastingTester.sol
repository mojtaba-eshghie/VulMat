// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn/squeeth-monorepo-427ba395545de44920206deaa4bcc217b3964952/packages/hardhat/contracts/libs/Uint256Casting.sol

//SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

library Uint256Casting {
    /**
     * @notice cast a uint256 to a uint128, revert on overflow
     * @param y the uint256 to be downcasted
     * @return z the downcasted integer, now type uint128
     */
    function toUint128(uint256 y) internal pure returns (uint128 z) {
        require((z = uint128(y)) == y, "OF128");
    }

    /**
     * @notice cast a uint256 to a uint96, revert on overflow
     * @param y the uint256 to be downcasted
     * @return z the downcasted integer, now type uint96
     */
    function toUint96(uint256 y) internal pure returns (uint96 z) {
        require((z = uint96(y)) == y, "OF96");
    }

    /**
     * @notice cast a uint256 to a uint32, revert on overflow
     * @param y the uint256 to be downcasted
     * @return z the downcasted integer, now type uint32
     */
    function toUint32(uint256 y) internal pure returns (uint32 z) {
        require((z = uint32(y)) == y, "OF32");
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn/squeeth-monorepo-427ba395545de44920206deaa4bcc217b3964952/packages/hardhat/contracts/test/CastingTester.sol

//SPDX-License-Identifier: MIT

pragma solidity =0.7.6;

contract CastingTester{    
    using Uint256Casting for uint256;

    function testToUint128(uint256 y) external pure returns (uint128 z) {
        return y.toUint128();
    }

    function testToUint96(uint256 y) external pure returns (uint96 z) {
        return y.toUint96();
    }

    function testToUint32(uint256 y) external pure returns (uint32 z) {
        return y.toUint32();
    }
}
