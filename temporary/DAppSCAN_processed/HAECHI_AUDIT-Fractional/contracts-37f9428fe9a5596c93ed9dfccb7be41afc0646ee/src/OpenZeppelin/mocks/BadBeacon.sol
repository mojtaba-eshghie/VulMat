// File: ../sc_datasets/DAppSCAN/HAECHI_AUDIT-Fractional/contracts-37f9428fe9a5596c93ed9dfccb7be41afc0646ee/src/OpenZeppelin/mocks/BadBeacon.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract BadBeaconNoImpl {
}

contract BadBeaconNotContract {
    function implementation() external pure returns (address) {
        return address(0x1);
    }
}
