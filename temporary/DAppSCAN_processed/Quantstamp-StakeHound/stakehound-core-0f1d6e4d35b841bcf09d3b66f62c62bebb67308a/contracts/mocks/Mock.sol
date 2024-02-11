// File: ../sc_datasets/DAppSCAN/Quantstamp-StakeHound/stakehound-core-0f1d6e4d35b841bcf09d3b66f62c62bebb67308a/contracts/mocks/Mock.sol

// contracts/StakedToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

contract Mock {
    event FunctionCalled(string instanceName, string functionName, address caller);
    event FunctionArguments(uint256[] uintVals, int256[] intVals);
    event ReturnValueInt256(int256 val);
    event ReturnValueUInt256(uint256 val);
}
