// File: ../sc_datasets/DAppSCAN/Smartdec-Opium Smart Contracts Security Analysis/opium-contracts-60ff6f80996b83f6ad19c35b74480fef34f7dc03/contracts/Lib/LibCommission.sol

pragma solidity ^0.5.4;

/// @title Opium.Lib.LibCommission contract defines constants for Opium commissions
contract LibCommission {
    // Represents 100% base for commissions calculation
    uint256 constant COMMISSION_BASE = 10000;

    // Represents 100% base for Opium commission
    uint256 constant OPIUM_COMMISSION_BASE = 10;

    // Represents which part of `syntheticId` author commissions goes to opium
    uint256 constant OPIUM_COMMISSION_PART = 1;
}
