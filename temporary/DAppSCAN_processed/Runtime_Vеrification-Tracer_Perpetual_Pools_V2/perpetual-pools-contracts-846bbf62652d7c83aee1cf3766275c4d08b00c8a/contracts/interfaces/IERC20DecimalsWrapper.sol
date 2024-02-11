// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-Tracer_Perpetual_Pools_V2/perpetual-pools-contracts-846bbf62652d7c83aee1cf3766275c4d08b00c8a/contracts/interfaces/IERC20DecimalsWrapper.sol

//SPDX-License-Identifier: CC-BY-NC-ND-4.0
pragma solidity 0.8.7;

/// @title The decimals interface for extending the ERC20 interface
interface IERC20DecimalsWrapper {
    function decimals() external view returns (uint8);
}
