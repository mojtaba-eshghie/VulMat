// File: ../sc_datasets/DAppSCAN/Quantstamp-MetaVault V2/metavault-3538b8a8c1ea4ec2b68a635c48b938aa1acfbc26/contracts/metavault/controllers/StrategyControllerV1.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

// Interface now only used for live migration test
interface StrategyControllerV1 {
    function setInvestEnabled(bool) external;
    function withdrawAll(address) external;
}
