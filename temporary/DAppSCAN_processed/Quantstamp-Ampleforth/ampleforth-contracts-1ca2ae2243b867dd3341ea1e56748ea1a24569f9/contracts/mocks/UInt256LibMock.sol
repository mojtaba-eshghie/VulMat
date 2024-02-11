// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/Mock.sol

pragma solidity 0.4.24;


contract Mock {
    event FunctionCalled(string instanceName, string functionName, address caller);
    event FunctionArguments(uint256[] uintVals, int256[] intVals);
    event ReturnValueInt256(int256 val);
    event ReturnValueUInt256(uint256 val);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/lib/UInt256Lib.sol

pragma solidity 0.4.24;


/**
 * @title Various utilities useful for uint256.
 */
library UInt256Lib {

    uint256 private constant MAX_INT256 = ~(uint256(1) << 255);

    /**
     * @dev Safely converts a uint256 to an int256.
     */
    function toInt256Safe(uint256 a)
        internal
        pure
        returns (int256)
    {
        require(a <= MAX_INT256);
        return int256(a);
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Ampleforth/ampleforth-contracts-1ca2ae2243b867dd3341ea1e56748ea1a24569f9/contracts/mocks/UInt256LibMock.sol

pragma solidity 0.4.24;


contract UInt256LibMock is Mock {
    function toInt256Safe(uint256 a)
        external
        returns (int256)
    {
        int256 result = UInt256Lib.toInt256Safe(a);
        emit ReturnValueInt256(result);
        return result;
    }
}
