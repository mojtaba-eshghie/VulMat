// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-ElementFinance/elf-contracts-eed369562ac50398c10fd0a56dc287a29002d3f8/contracts/test/CodeSizeChecker.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

contract CodeSizeChecker {
    function codeSize(address which) external view returns (uint256 ret) {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            ret := extcodesize(which)
        }
    }
}
