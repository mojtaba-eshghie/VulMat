// File: ../sc_datasets/DAppSCAN/HAECHI_AUDIT-Pickle_Finance/protocol-9b0f330a16bc35c964211feae3b335ab398c01b6/src/tests/lib/hevm.sol

pragma solidity ^0.6.0;

interface Hevm {
    function warp(uint256) external;
    function roll(uint x) external;
    function store(address c, bytes32 loc, bytes32 val) external;
}
