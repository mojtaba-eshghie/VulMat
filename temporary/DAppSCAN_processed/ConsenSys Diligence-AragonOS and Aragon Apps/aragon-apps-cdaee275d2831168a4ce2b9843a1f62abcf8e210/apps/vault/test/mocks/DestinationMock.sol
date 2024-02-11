// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AragonOS and Aragon Apps/aragon-apps-cdaee275d2831168a4ce2b9843a1f62abcf8e210/apps/vault/test/mocks/DestinationMock.sol

pragma solidity 0.4.24;


contract DestinationMock {
    uint256 test;

    function () external payable {
        test = test + 1;
    }
}
