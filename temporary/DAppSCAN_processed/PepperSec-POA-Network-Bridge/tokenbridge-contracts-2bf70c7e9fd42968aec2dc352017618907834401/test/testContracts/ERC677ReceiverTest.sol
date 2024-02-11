// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/contracts/ERC677Receiver.sol

pragma solidity 0.4.24;


contract ERC677Receiver {
  function onTokenTransfer(address _from, uint _value, bytes _data) external returns(bool);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/test/testContracts/ERC677ReceiverTest.sol

pragma solidity ^0.4.19;

contract ERC677ReceiverTest is ERC677Receiver {
    address public from;
    uint public value;
    bytes public data;
    uint public someVar = 0;

    function onTokenTransfer(address _from, uint _value, bytes _data) external returns(bool) {
        from = _from;
        value = _value;
        data = _data;
        require(address(this).call(_data));
        return true;
    }

    function doSomething(uint _value) public {
        someVar = _value;
    }
}
