// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-ElementFinance/elf-contracts-637c6f959315cbb11a164555e588520c7d89122b/contracts/test/CodeSizeChecker.sol

pragma solidity ^0.8.0;

contract CodeSizeChecker {
    function codeSize(address which) external view returns (uint256 ret) {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            ret := extcodesize(which)
        }
    }
}
