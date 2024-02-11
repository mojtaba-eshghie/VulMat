// File: ../sc_datasets/DAppSCAN/HAECHI_AUDIT-Fractional/contracts-37f9428fe9a5596c93ed9dfccb7be41afc0646ee/src/OpenZeppelin/mocks/EtherReceiverMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherReceiverMock {
    bool private _acceptEther;

    function setAcceptEther(bool acceptEther) public {
        _acceptEther = acceptEther;
    }

    receive () external payable {
        if (!_acceptEther) {
            revert();
        }
    }
}
