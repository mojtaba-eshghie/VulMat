// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/apps/vault/test/mocks/DestinationMock.sol

pragma solidity 0.4.24;


contract DestinationMock {
    uint256 test;

    function () external payable {
        test = test + 1;
    }
}
