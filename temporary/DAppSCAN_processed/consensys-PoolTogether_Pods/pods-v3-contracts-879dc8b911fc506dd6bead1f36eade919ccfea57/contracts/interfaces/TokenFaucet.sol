// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether_Pods/pods-v3-contracts-879dc8b911fc506dd6bead1f36eade919ccfea57/contracts/interfaces/TokenFaucet.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

interface TokenFaucet {
    /// @notice The timestamp at which the tokens were last dripped
    // uint32 public lastDripTimestamp;
    function claim(address user) external returns (uint256);

    function dripRatePerSecond() external returns (uint256);

    function exchangeRateMantissa() external returns (uint112);

    function totalUnclaimed() external returns (uint112);

    function lastDripTimestamp() external returns (uint32);
}
