// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/stats/ChainlinkTokenPairPriceFeed/IENS.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

// Based on https://github.com/ensdomains/ens/blob/master/contracts/ENS.sol
interface IENS {
    function resolver(bytes32 node) external view returns (IENSResolver);
}

// Based on https://github.com/ensdomains/resolvers/blob/master/contracts/profiles/AddrResolver.sol
interface IENSResolver {
    function addr(bytes32 node) external view returns (address);
}
