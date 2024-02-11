// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/ERC677Receiver.sol

pragma solidity 0.4.24;


contract ERC677Receiver {
  function onTokenTransfer(address _from, uint _value, bytes _data) external returns(bool);
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/test/testContracts/ERC677ReceiverTest.sol

pragma solidity ^0.4.19;

contract ERC677ReceiverTest is ERC677Receiver {
    address public from;
    uint public value;
    bytes public data;
    uint public someVar = 0;

    function onTokenTransfer(address _from, uint256 _value, bytes _data) external returns(bool) {
        from = _from;
        value = _value;
        data = _data;
        address(this).call(_data);
        return true;
    }

    function doSomething(uint _value) public {
        someVar = _value;
    }
}
