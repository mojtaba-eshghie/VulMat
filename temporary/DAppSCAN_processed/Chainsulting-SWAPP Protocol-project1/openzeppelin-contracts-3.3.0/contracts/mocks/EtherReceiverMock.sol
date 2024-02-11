// File: ../sc_datasets/DAppSCAN/Chainsulting-SWAPP Protocol-project1/openzeppelin-contracts-3.3.0/contracts/mocks/EtherReceiverMock.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

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
