// File: ../sc_datasets/DAppSCAN/Chainsulting-1inch/liquidity-protocol-master/contracts/mocks/TokenWithBytes32SymbolMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


contract TokenWithBytes32SymbolMock {
    bytes32 public symbol = "ABC";

    constructor(bytes32 s) public {
        symbol = s;
    }
}
