// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-Element_Finance_Governance_Security_Audit_Report/council-3d751c959b42573c78ccd0bccbc80424bf6d9a90/contracts/mocks/StorageRead.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.3;

contract ReadAndWriteAnyStorage {
    function readStorage(uint256 slot) public view returns (bytes32 data) {
        assembly {
            data := sload(slot)
        }
    }

    function writeStorage(uint256 slot, bytes32 data) public {
        assembly {
            sstore(slot, data)
        }
    }
}
