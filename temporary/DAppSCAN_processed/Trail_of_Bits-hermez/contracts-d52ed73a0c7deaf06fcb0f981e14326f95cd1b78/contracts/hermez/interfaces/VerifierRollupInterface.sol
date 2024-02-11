// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-hermez/contracts-d52ed73a0c7deaf06fcb0f981e14326f95cd1b78/contracts/hermez/interfaces/VerifierRollupInterface.sol

// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.6.12;

/**
 * @dev Define interface verifier
 */
interface VerifierRollupInterface {
    function verifyProof(
        uint256[2] calldata proofA,
        uint256[2][2] calldata proofB,
        uint256[2] calldata proofC,
        uint256[1] calldata input
    ) external view returns (bool);
}
