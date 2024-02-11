// File: ../sc_datasets/DAppSCAN/consensys-0x_v3_Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/packages/sol-tracing-utils/test/fixtures/contracts/SimpleStorage.sol

pragma solidity ^0.4.21;

contract SimpleStorage {
    uint public storedData;
    function set(uint x) {
        storedData = x;
    }
    function get() constant returns (uint retVal) {
        return storedData;
    }
}
