// File: ../sc_datasets/DAppSCAN/Chainsecurity-Primitive Finance  Core engine smart contracts/rmm-core-c44f8ca1ee43772ec4ba56e031bdb6fb8aac0ca3/contracts/test/callbacks/Scenarios.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.6;

abstract contract Scenarios {
    Scenario public scenario = Scenario.SUCCESS;

    enum Scenario {
        FAIL,
        SUCCESS,
        RISKY_ONLY,
        STABLE_ONLY,
        REENTRANCY
    }

    function risky() public view virtual returns (address);

    function stable() public view virtual returns (address);

    function getCaller() public view virtual returns (address);
}
