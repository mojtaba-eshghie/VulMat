// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/packages/sol-tracing-utils/test/fixtures/contracts/SolcovIgnore.sol

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
