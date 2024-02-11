// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/vaults/meter/interfaces/IV1.sol

// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface IV1 {
    function mint(address to, uint256 tokenId_) external;
    function burn(uint256 tokenId_) external;
    function burnFromVault(uint vaultId_) external;
    function exists(uint256 tokenId_) external view returns (bool);
}
