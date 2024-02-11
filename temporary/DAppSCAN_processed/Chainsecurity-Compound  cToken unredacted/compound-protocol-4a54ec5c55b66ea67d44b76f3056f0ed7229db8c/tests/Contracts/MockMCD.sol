// File: ../sc_datasets/DAppSCAN/Chainsecurity-Compound  cToken unredacted/compound-protocol-4a54ec5c55b66ea67d44b76f3056f0ed7229db8c/tests/Contracts/MockMCD.sol

// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.6;

contract MockPot {

    uint public dsr;  // the Dai Savings Rate

    constructor(uint dsr_) {
        setDsr(dsr_);
    }

    function setDsr(uint dsr_) public {
        dsr = dsr_;
    }
}

contract MockJug {

    struct Ilk {
        uint duty;
        uint rho;
    }

    mapping (bytes32 => Ilk) public ilks;
    uint public base;

    constructor(uint duty_, uint base_) {
        setETHDuty(duty_);
        setBase(base_);
    }

    function setBase(uint base_) public {
        base = base_;
    }

    function setETHDuty(uint duty_) public {
        ilks["ETH-A"].duty = duty_;
    }
}
