// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-Layer_Zero/LayerZero-a5b266aa54714035314cbe5e451b2ec0db81b552/contracts/interfaces/ILayerZeroTreasury.sol

// SPDX-License-Identifier: BUSL-1.1

pragma solidity >=0.5.0;

interface ILayerZeroTreasury {
    function getFees(bool payInZro, uint relayerFee, uint oracleFee) external view returns (uint);
}
