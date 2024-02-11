// File: ../sc_datasets/DAppSCAN/Chainsulting-SWAPP Protocol-project2/openzeppelin-contracts-4.2.0/contracts/mocks/EtherReceiverMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherReceiverMock {
    bool private _acceptEther;

    function setAcceptEther(bool acceptEther) public {
        _acceptEther = acceptEther;
    }

    receive() external payable {
        if (!_acceptEther) {
            revert();
        }
    }
}
