// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/misc/test.sol

pragma solidity ^0.8.0;


interface ITest {
    function add(uint a, uint b) external;
}

contract Test is ITest {
    uint public a;
    uint public b;
    uint public sum;
    constructor(uint a, uint b){
        sum = a + b;
    }

    function add(uint a, uint b) external override {
        sum = a+b;
    }
}
