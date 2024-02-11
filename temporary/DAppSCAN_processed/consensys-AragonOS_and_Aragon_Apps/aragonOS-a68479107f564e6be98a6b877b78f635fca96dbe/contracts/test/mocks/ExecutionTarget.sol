// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/test/mocks/ExecutionTarget.sol

pragma solidity 0.4.24;


contract ExecutionTarget {
    uint public counter;

    function execute() public {
        counter += 1;
        emit Executed(counter);
    }

    function failExecute() public pure {
        revert();
    }

    function setCounter(uint x) public {
        counter = x;
    }

    event Executed(uint x);
}
