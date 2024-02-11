// File: ../sc_datasets/DAppSCAN/Quantstamp-Popsicle/PopsicleV3Optimizer-d1513776bffd634e9e83330495adce9d9d0a5cb0/contracts/popsicle-v3-optimizer/libraries/PositionKey.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

library PositionKey {
    /// @dev Returns the key of the position in the core library
    function compute(
        address owner,
        int24 tickLower,
        int24 tickUpper
    ) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(owner, tickLower, tickUpper));
    }
}
