// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Library for utility functions
library Utils {
    // Checks if a bytes array is empty
    function isBytesEmpty(bytes memory data) internal pure returns (bool) {
        return data.length == 0;
    }
}

// Interface declaring the multiDelegatecall function
interface IMultiDelegatecall {
    function multiDelegatecall(bytes[] memory data) external payable returns (bytes[] memory results);
}

// Abstract contract for delegatecall operations
abstract contract DelegatecallOperations {
    // Abstract function to perform multiple delegate calls
    function multiDelegatecall(bytes[] memory data) external payable virtual returns (bytes[] memory results);
}

// Contract implementing multi delegatecall functionality with tracking
contract MultiDelegatecall is IMultiDelegatecall {
    error DelegatecallFailed();

    // State variable to track the total number of delegate calls
    uint public totalDelegatecallsMade;

    function multiDelegatecall(
        bytes[] memory data
    ) external payable override returns (bytes[] memory results) {
        results = new bytes[](data.length);

        for (uint i; i < data.length; i++) {
            require(!Utils.isBytesEmpty(data[i]), "Empty data element");

            (bool ok, bytes memory res) = address(this).delegatecall(data[i]);
            if (!ok) {
                revert DelegatecallFailed();
            }
            results[i] = res;
            totalDelegatecallsMade++; // Increment on successful delegatecall
        }
    }
}

// Example contract using multi delegatecall
contract TestMultiDelegatecall is MultiDelegatecall {
    event Log(address caller, string func, uint i);

    function func1(uint x, uint y) external {
        emit Log(msg.sender, "func1", x + y);
    }

    function func2() external returns (uint) {
        emit Log(msg.sender, "func2", 2);
        return 111;
    }

    mapping(address => uint) public balanceOf;

    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }
}

pragma solidity ^0.8.2;
// Helper contract for generating call data
contract Helper {
    function getFunc1Data(uint x, uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func1.selector, x, y);
    }

    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func2.selector);
    }

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.mint.selector);
    }
}
