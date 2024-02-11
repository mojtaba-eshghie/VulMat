// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/gasprofile/test-contracts/FooBase.sol

pragma solidity ^0.4.24;

contract FooBase {
    uint s;

    function foo (uint c) public {
        for (uint i = 0; i < c; i++) {
            callBar(i);
        }

        if (s > 1) {
            s += 1;
        }
    }

    function callBar(uint i) public {}
}
