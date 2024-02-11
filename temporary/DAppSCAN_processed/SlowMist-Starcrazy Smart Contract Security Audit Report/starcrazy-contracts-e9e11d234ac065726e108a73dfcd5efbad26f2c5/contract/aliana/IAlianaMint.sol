// File: ../sc_datasets/DAppSCAN/SlowMist-Starcrazy Smart Contract Security Audit Report/starcrazy-contracts-e9e11d234ac065726e108a73dfcd5efbad26f2c5/contract/aliana/IAlianaMint.sol

pragma solidity ^0.5.0;

/// @title SEKRETOOOO
contract IAlianaMint {
    function depositedTokens(address _owner)
        public
        view
        returns (uint256[] memory ownerTokens);
}
