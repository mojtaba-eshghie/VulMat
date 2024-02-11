// File: ../sc_datasets/DAppSCAN/Quantstamp-MetaVault V2/metavault-3538b8a8c1ea4ec2b68a635c48b938aa1acfbc26/contracts/interfaces/MStable.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

interface MStable {
    function mint(address, uint) external;
    function redeem(address, uint) external;
}

interface mSavings {
    function depositSavings(uint) external;
    function creditBalances(address) external view returns (uint);
    function redeem(uint) external;
    function exchangeRate() external view returns (uint);
}
