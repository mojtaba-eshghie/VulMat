// File: ../sc_datasets/DAppSCAN/openzeppelin-Ribbon_Finance/ribbon-v2-3fa3bec15ad1e2b18ad87f979b87a68368497f13/contracts/tests/MockPriceOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract MockPriceOracle {
    uint256 private _decimals;

    function setDecimals(uint256 decimals) external {
        _decimals = decimals;
    }

    function decimals() external view returns (uint256) {
        return _decimals;
    }
}
