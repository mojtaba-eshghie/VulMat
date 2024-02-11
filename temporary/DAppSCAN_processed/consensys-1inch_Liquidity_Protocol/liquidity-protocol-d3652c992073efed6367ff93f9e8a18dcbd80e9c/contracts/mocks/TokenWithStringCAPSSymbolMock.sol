// File: ../sc_datasets/DAppSCAN/consensys-1inch_Liquidity_Protocol/liquidity-protocol-d3652c992073efed6367ff93f9e8a18dcbd80e9c/contracts/mocks/TokenWithStringCAPSSymbolMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


contract TokenWithStringCAPSSymbolMock {
    // solhint-disable var-name-mixedcase
    string public SYMBOL = "ABC";

    constructor(string memory s) public {
        SYMBOL = s;
    }
}
