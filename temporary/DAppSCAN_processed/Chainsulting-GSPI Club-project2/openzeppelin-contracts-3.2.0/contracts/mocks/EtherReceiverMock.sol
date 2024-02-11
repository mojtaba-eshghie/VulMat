// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project2/openzeppelin-contracts-3.2.0/contracts/mocks/EtherReceiverMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

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
