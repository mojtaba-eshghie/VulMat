// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-ElementFinance/elf-contracts-b9ab6095a211ccb81941a5104c581e3564a97502/contracts/test/CodeSizeChecker.sol

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
