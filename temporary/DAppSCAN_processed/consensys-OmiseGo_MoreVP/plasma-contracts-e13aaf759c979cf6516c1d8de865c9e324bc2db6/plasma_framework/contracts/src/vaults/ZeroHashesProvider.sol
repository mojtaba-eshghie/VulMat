// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/vaults/ZeroHashesProvider.sol

pragma solidity 0.5.11;

library ZeroHashesProvider {

    /**
     * @dev Pre-computes zero hashes to be used for building Merkle tree for deposit block
     */
    function getZeroHashes() internal pure returns (bytes32[16] memory) {
        bytes32[16] memory zeroHashes;
        bytes32 zeroHash = keccak256(abi.encodePacked(uint256(0)));
        for (uint i = 0; i < 16; i++) {
            zeroHashes[i] = zeroHash;
            zeroHash = keccak256(abi.encodePacked(zeroHash, zeroHash));
        }
        return zeroHashes;
    }
}
