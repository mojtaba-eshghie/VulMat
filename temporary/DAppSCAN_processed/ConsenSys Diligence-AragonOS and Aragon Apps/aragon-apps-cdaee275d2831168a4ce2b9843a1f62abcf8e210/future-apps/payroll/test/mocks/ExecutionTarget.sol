// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AragonOS and Aragon Apps/aragon-apps-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/ExecutionTarget.sol

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
