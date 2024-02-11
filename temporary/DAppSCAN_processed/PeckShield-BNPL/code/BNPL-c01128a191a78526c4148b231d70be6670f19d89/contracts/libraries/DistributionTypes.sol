// File: ../sc_datasets/DAppSCAN/PeckShield-BNPL/code/BNPL-c01128a191a78526c4148b231d70be6670f19d89/contracts/libraries/DistributionTypes.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

library DistributionTypes {
    struct AssetConfigInput {
        uint104 emissionPerSecond;
        uint256 totalStaked;
        address underlyingAsset;
    }

    struct UserStakeInput {
        address underlyingAsset;
        uint256 stakedByUser;
        uint256 totalStaked;
    }
}
