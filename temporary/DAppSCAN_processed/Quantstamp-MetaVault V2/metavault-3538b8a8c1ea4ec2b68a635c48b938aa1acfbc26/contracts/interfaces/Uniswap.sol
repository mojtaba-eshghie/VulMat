// File: ../sc_datasets/DAppSCAN/Quantstamp-MetaVault V2/metavault-3538b8a8c1ea4ec2b68a635c48b938aa1acfbc26/contracts/interfaces/Uniswap.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

interface Uni {
    function swapExactTokensForTokens(uint, uint, address[] calldata, address, uint) external;
}
