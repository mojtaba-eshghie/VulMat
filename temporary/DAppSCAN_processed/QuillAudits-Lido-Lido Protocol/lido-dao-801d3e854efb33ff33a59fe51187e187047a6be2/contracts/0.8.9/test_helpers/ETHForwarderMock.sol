// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Lido Protocol/lido-dao-801d3e854efb33ff33a59fe51187e187047a6be2/contracts/0.8.9/test_helpers/ETHForwarderMock.sol

// SPDX-FileCopyrightText: 2021 Lido <info@lido.fi>

//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

contract ETHForwarderMock {
    constructor(address payable _target) payable {
        selfdestruct(_target);
    }
}
