// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/utils/OnlyWithValue.sol

pragma solidity 0.5.11;

contract OnlyWithValue {
    modifier onlyWithValue(uint256 _value) {
        require(msg.value == _value, "Input value must match msg.value");
        _;
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/mocks/utils/OnlyWithValueMock.sol

pragma solidity 0.5.11;

contract OnlyWithValueMock is OnlyWithValue {
    event OnlyWithValuePassed();

    function checkOnlyWithValue(uint256 _value) public payable onlyWithValue(_value) {
        emit OnlyWithValuePassed();
    }
}
