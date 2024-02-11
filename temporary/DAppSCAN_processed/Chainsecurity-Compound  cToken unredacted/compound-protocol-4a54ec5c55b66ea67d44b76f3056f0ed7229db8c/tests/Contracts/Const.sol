// File: ../sc_datasets/DAppSCAN/Chainsecurity-Compound  cToken unredacted/compound-protocol-4a54ec5c55b66ea67d44b76f3056f0ed7229db8c/tests/Contracts/Const.sol

// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.6;

contract ConstBase {
    uint public constant C = 1;

    function c() virtual public pure returns (uint) {
        return 1;
    }

    function ADD(uint a) public view returns (uint) {
        // tells compiler to accept view instead of pure
        if (false) {
            C + block.timestamp;
        }
        return a + C;
    }

    function add(uint a) public view returns (uint) {
        // tells compiler to accept view instead of pure
        if (false) {
            C + block.timestamp;
        }
        return a + c();
    }
}

contract ConstSub is ConstBase {
    function c() override public pure returns (uint) {
        return 2;
    }
}
