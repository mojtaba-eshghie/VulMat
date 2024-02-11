// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-DeFi Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/reflexer/IOracleRelayer.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IOracleRelayer {
    struct CollateralType {
        address orcl;
        uint256 safetyCRatio;
    }

    mapping (bytes32 => CollateralType) public collateralTypes;

    function redemptionPrice() public virtual returns (uint256);
    uint256 public redemptionRate;
}
