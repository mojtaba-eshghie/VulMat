// File: ../sc_datasets/DAppSCAN/consensys-rICO/rICO-smart-contracts-77517a4dceed53ff7c5a7f7580cb805831a7f8d5/test/solc_tests/helpers/ExecutionTarget.sol

pragma solidity ^0.5.10;

contract ExecutionTarget {
    uint public counter;

    function execute() public {
        counter += 1;
        emit Executed(counter);
    }

    function setCounter(uint x) public {
        counter = x;
    }

    event Executed(uint x);
}
