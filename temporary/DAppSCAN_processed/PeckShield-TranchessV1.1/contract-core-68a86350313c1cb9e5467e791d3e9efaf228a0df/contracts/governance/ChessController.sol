// File: ../sc_datasets/DAppSCAN/PeckShield-TranchessV1.1/contract-core-68a86350313c1cb9e5467e791d3e9efaf228a0df/contracts/governance/ChessController.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

contract ChessController {
    /// @notice Get Fund relative weight (not more than 1.0) normalized to 1e18
    ///         (e.g. 1.0 == 1e18).
    /// @return relativeWeight Value of relative weight normalized to 1e18
    function getFundRelativeWeight(
        address, /*account*/
        uint256 /*timestamp*/
    ) external pure returns (uint256 relativeWeight) {
        relativeWeight = 1e18;
    }
}
