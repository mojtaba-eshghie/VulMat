// File: ../sc_datasets/DAppSCAN/PeckShield-Pandora/smart-contract-d0aa3193b8ffcd7fc84481c30e16283837319719/contracts/0.6.x/contracts/mock/MockOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;


contract MockOracle{
    function consult() external view returns (uint256) {
        return 1e6;
    }
}
