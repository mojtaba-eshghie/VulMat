// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/Mock.sol

pragma solidity 0.4.24;


contract Mock {
    event FunctionCalled(string instanceName, string functionName, address caller);
    event FunctionArguments(uint256[] uintVals, int256[] intVals);
    event ReturnValueInt256(int256 val);
    event ReturnValueUInt256(uint256 val);
}
