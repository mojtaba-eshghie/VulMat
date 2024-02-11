// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-dev/test/mock/application/functions/ApplicationMockFuncLib.sol

pragma solidity ^0.4.21;


library ApplicationMockFuncLib {

    function mockFn() public pure returns (bytes32[] store_data) {
        store_data = new bytes32[](4);
    }
}
