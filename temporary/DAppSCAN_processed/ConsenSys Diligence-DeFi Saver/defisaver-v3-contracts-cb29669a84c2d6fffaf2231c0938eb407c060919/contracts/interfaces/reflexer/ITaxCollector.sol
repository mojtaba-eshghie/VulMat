// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-DeFi Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/reflexer/ITaxCollector.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract ITaxCollector {
    struct CollateralType {
        uint256 stabilityFee;
        uint256 updateTime;
    }

    mapping (bytes32 => CollateralType) public collateralTypes;

    function taxSingle(bytes32) public virtual returns (uint);
}
