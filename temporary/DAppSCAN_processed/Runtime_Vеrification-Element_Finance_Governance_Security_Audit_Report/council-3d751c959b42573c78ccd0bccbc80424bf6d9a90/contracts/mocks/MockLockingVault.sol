// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-Element_Finance_Governance_Security_Audit_Report/council-3d751c959b42573c78ccd0bccbc80424bf6d9a90/contracts/mocks/MockLockingVault.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

contract MockLockingVault {
    mapping(address => uint256) public deposits;
    mapping(address => address) public delegation;

    function deposit(
        address fundedAccount,
        uint256 amount,
        address firstDelegation
    ) external {
        deposits[fundedAccount] += amount;
        delegation[fundedAccount] = firstDelegation;
    }
}
