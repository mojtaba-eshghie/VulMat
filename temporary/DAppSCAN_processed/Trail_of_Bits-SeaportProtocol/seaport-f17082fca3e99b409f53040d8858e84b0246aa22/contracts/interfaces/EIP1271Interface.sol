// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-SeaportProtocol/seaport-f17082fca3e99b409f53040d8858e84b0246aa22/contracts/interfaces/EIP1271Interface.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

interface EIP1271Interface {
    function isValidSignature(bytes32 digest, bytes calldata signature)
        external
        view
        returns (bytes4);
}
