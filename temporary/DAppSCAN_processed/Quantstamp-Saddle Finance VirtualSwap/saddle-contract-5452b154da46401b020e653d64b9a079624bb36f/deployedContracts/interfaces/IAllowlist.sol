// File: ../sc_datasets/DAppSCAN/Quantstamp-Saddle Finance VirtualSwap/saddle-contract-5452b154da46401b020e653d64b9a079624bb36f/deployedContracts/interfaces/IAllowlist.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IAllowlist {
    function getPoolAccountLimit(address poolAddress)
        external
        view
        returns (uint256);

    function getPoolCap(address poolAddress) external view returns (uint256);

    function verifyAddress(address account, bytes32[] calldata merkleProof)
        external
        returns (bool);
}
