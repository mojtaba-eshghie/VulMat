// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-Element_Finance_Governance_Security_Audit_Report/council-3d751c959b42573c78ccd0bccbc80424bf6d9a90/contracts/mocks/MockCoreVoting.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.3;

contract MockCoreVoting {
    // We simply allow voting vaults to be registered by any caller
    // We use this in testing the GSC contract

    mapping(address => bool) public approvedVaults;

    function setVault(address vault, bool what) external {
        approvedVaults[vault] = what;
    }
}
