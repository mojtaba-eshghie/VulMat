// File: ../sc_datasets/DAppSCAN/PeckShield-AaveV3/code/aave-v3-core-14f6148e21b477d78347db6a1603039c9559e275/contracts/interfaces/ISequencerOracle.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

/**
 * @title ISequencerOracle
 * @author Aave
 * @notice Defines the basic interface for a Sequencer oracle.
 */
interface ISequencerOracle {
  function latestAnswer() external view returns (bool, uint256);
}
