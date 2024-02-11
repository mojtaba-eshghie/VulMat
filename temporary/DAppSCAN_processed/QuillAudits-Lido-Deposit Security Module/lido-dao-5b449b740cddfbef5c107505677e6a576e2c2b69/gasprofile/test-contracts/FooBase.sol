// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Deposit Security Module/lido-dao-5b449b740cddfbef5c107505677e6a576e2c2b69/gasprofile/test-contracts/FooBase.sol

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
