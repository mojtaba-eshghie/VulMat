// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol/contracts/utils/interfaces/IOwnableCallForwarder.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IOwnableCallForwarder {
    function forwardCall(
        address forwardTarget,
        bytes calldata forwardedCalldata
    ) external payable returns (bytes memory returnedData);
}
