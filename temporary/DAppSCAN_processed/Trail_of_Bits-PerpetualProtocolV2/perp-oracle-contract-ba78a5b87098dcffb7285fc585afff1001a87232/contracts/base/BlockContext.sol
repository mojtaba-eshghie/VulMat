// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-PerpetualProtocolV2/perp-oracle-contract-ba78a5b87098dcffb7285fc585afff1001a87232/contracts/base/BlockContext.sol

// SPDX-License-Identifier: MIT License
pragma solidity 0.7.6;

abstract contract BlockContext {
    function _blockTimestamp() internal view virtual returns (uint256) {
        // Reply from Arbitrum
        // block.timestamp returns timestamp at the time at which the sequencer receives the tx.
        // It may not actually correspond to a particular L1 block
        return block.timestamp;
    }

    function _blockNumber() internal view virtual returns (uint256) {
        return block.number;
    }
}
