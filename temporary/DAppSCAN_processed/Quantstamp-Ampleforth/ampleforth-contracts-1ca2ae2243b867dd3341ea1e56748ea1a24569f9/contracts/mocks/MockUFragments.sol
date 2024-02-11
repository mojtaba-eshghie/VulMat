// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/Mock.sol

pragma solidity 0.4.24;


contract Mock {
    event FunctionCalled(string instanceName, string functionName, address caller);
    event FunctionArguments(uint256[] uintVals, int256[] intVals);
    event ReturnValueInt256(int256 val);
    event ReturnValueUInt256(uint256 val);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/MockUFragments.sol

pragma solidity 0.4.24;

contract MockUFragments is Mock {
    uint256 private _supply;

    // Methods to mock data on the chain
    function storeSupply(uint256 supply)
        public
    {
        _supply = supply;
    }

    // Mock methods
    function rebase(uint256 epoch, int256 supplyDelta)
        public
        returns (uint256)
    {
        emit FunctionCalled("UFragments", "rebase", msg.sender);
        uint256[] memory uintVals = new uint256[](1);
        uintVals[0] = epoch;
        int256[] memory intVals = new int256[](1);
        intVals[0] = supplyDelta;
        emit FunctionArguments(uintVals, intVals);
        return uint256(int256(_supply) + int256(supplyDelta));
    }

    function totalSupply()
        public
        view
        returns (uint256)
    {
        return _supply;
    }
}
