// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/ExecutionTarget.sol

pragma solidity 0.4.18;

contract ExecutionTarget {
    uint public counter;

    function execute() external {
        counter += 1;
        Executed(counter);
    }

    function setCounter(uint x) external {
        counter = x;
    }

    event Executed(uint x);
}
