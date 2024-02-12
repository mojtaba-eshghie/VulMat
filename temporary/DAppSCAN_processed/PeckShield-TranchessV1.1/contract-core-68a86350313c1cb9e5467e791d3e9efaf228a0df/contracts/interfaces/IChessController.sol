// File: ../sc_datasets/DAppSCAN/PeckShield-TranchessV1.1/contract-core-68a86350313c1cb9e5467e791d3e9efaf228a0df/contracts/interfaces/IChessController.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

interface IChessController {
    function getFundRelativeWeight(address account, uint256 timestamp)
        external
        view
        returns (uint256);
}