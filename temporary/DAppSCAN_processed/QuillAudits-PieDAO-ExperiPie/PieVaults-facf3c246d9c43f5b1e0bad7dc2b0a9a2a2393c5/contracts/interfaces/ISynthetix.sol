// File: ../sc_datasets/DAppSCAN/QuillAudits-PieDAO-ExperiPie/PieVaults-facf3c246d9c43f5b1e0bad7dc2b0a9a2a2393c5/contracts/interfaces/ISynthetix.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

interface ISynthetix {
    function exchange(bytes32 sourceCurrencyKey, uint256 sourceAmount, bytes32 destinationCurrencyKey) external;
}
