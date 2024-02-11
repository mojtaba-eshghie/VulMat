// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-dd7fc9096637a699da64736d44d1bc8aaab53919/contracts/test/FallbackMock.sol

// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.11;

contract FallbackMock {

    uint private _minimalGasToSpend;
    uint private _iterator;

    constructor(uint minimalGasToSpend) {
        _minimalGasToSpend = minimalGasToSpend;
    }

    // solhint-disable-next-line comprehensive-interface, no-complex-fallback
    fallback() external payable {
        uint gasTotal = gasleft();
        while (gasTotal - gasleft() < _minimalGasToSpend) {
            _iterator++;
        }
    }
}
