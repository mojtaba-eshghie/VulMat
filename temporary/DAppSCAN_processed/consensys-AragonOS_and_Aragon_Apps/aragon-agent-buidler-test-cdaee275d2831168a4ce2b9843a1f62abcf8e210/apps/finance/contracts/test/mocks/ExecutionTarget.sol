// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/apps/finance/contracts/test/mocks/ExecutionTarget.sol

pragma solidity 0.4.24;


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
