// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/Mock.sol

pragma solidity 0.4.24;


contract Mock {
    event FunctionCalled(string instanceName, string functionName, address caller);
    event FunctionArguments(uint256[] uintVals, int256[] intVals);
    event ReturnValueInt256(int256 val);
    event ReturnValueUInt256(uint256 val);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/MockOracle.sol

pragma solidity 0.4.24;

contract MockOracle is Mock {
    bool private _validity = true;
    uint256 private _data;
    string public name;

    constructor(string name_) public {
        name = name_;
    }

    // Mock methods
    function getData()
        external
        returns (uint256, bool)
    {
        emit FunctionCalled(name, "getData", msg.sender);
        uint256[] memory uintVals = new uint256[](0);
        int256[] memory intVals = new int256[](0);
        emit FunctionArguments(uintVals, intVals);
        return (_data, _validity);
    }

    // Methods to mock data on the chain
    function storeData(uint256 data)
        public
    {
        _data = data;
    }

    function storeValidity(bool validity)
        public
    {
        _validity = validity;
    }
}
