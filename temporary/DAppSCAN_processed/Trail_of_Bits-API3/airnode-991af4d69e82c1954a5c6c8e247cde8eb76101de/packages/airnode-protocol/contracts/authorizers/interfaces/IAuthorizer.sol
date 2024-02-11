// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol/contracts/authorizers/interfaces/IAuthorizer.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAuthorizer {
    function isAuthorized(
        bytes32 requestId,
        address airnode,
        bytes32 endpointId,
        address sponsor,
        address requester
    ) external view returns (bool);
}
