// File: ../sc_datasets/DAppSCAN/SlowMist-Starcrazy Smart Contract Security Audit Report/starcrazy-contracts-e9e11d234ac065726e108a73dfcd5efbad26f2c5/contract/token/IApproveAndCallFallBack.sol

pragma solidity ^0.5.0;

contract IApproveAndCallFallBack {
    function receiveApproval(
        address from,
        uint256 amount_,
        address token_,
        bytes memory data_
    ) public;
}
