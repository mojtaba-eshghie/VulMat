// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Deposit Security Module/lido-dao-5b449b740cddfbef5c107505677e6a576e2c2b69/contracts/0.8.9/test_helpers/NodeOperatorsRegistryMockForSecurityModule.sol

// SPDX-FileCopyrightText: 2021 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

/* See contracts/COMPILERS.md */
pragma solidity 0.8.9;

contract NodeOperatorsRegistryMockForSecurityModule {
    uint256 internal keysOpIndex;

    function getKeysOpIndex() external view returns (uint256 index) {
        return keysOpIndex;
    }

    function setKeysOpIndex(uint256 _newKeysOpIndex) external {
        keysOpIndex = _newKeysOpIndex;
    }
}
