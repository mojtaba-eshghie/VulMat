// File: ../sc_datasets/DAppSCAN/consensys-0x_Protocol_v2/0x-monorepo-a05b14e4d9659be1cc495ee33fd8962ce773f87f/packages/sol-cov/test/fixtures/contracts/SolcovIgnore.sol

pragma solidity ^0.4.21;

contract SolcovIgnore {
    uint public storedData;

    function set(uint x) public {
        /* solcov ignore next */
        storedData = x;
    }

    /* solcov ignore next */
    function get() constant public returns (uint retVal) {
        return storedData;
    }
}

/* solcov ignore next */
contract Ignore {
    function ignored() public returns (bool) {
        return false;
    }
}
