// File: ../sc_datasets/DAppSCAN/Quantstamp-Nomad/nomad-monorepo-2111a1d4756a26dfd01a5fb2b1784479e54a2886/solidity/nomad-core/contracts/test/MysteryMath.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

abstract contract MysteryMath {
    uint256 public stateVar;

    function setState(uint256 _var) external {
        stateVar = _var;
    }

    function getState() external view returns (uint256) {
        return stateVar;
    }

    function doMath(uint256 a, uint256 b)
        external
        pure
        virtual
        returns (uint256 _result);
}
