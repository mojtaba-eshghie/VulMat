// File: ../sc_datasets/DAppSCAN/openzeppelin-Ribbon_Finance/ribbon-v2-3fa3bec15ad1e2b18ad87f979b87a68368497f13/contracts/tests/MockVolatilityOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract MockVolatilityOracle {
    uint256 private _annualizedVol;

    function annualizedVol(address) external view returns (uint256) {
        return _annualizedVol;
    }

    function setAnnualizedVol(uint256 vol) external {
        _annualizedVol = vol;
    }
}
