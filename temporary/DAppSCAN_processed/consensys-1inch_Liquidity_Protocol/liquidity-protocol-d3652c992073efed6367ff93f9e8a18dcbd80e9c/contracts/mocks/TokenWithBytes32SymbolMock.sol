// File: ../sc_datasets/DAppSCAN/consensys-1inch_Liquidity_Protocol/liquidity-protocol-d3652c992073efed6367ff93f9e8a18dcbd80e9c/contracts/mocks/TokenWithBytes32SymbolMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


contract TokenWithBytes32SymbolMock {
    bytes32 public symbol = "ABC";

    constructor(bytes32 s) public {
        symbol = s;
    }
}
