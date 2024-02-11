// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/application/functions/ApplicationMockFuncLib.sol

pragma solidity ^0.4.21;


library ApplicationMockFuncLib {

    function mockFn() public pure returns (bytes32[] store_data) {
        store_data = new bytes32[](4);
    }
}
