// File: ../sc_datasets/DAppSCAN/consensys-0x_v3_Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/packages/sol-tracing-utils/test/fixtures/contracts/SolcovIgnore.sol

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
