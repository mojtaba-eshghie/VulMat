// File: ../sc_datasets/DAppSCAN/Chainsecurity-Compound  cToken unredacted/compound-protocol-4a54ec5c55b66ea67d44b76f3056f0ed7229db8c/tests/Contracts/Structs.sol

// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.6;

contract Structs {
    struct Outer {
        uint sentinel;
        mapping(address => Inner) inners;
    }

    struct Inner {
        uint16 a;
        uint16 b;
        uint96 c;
    }

    mapping(uint => Outer) public outers;

    function writeEach(uint id, uint16 a, uint16 b, uint96 c) public {
        Inner storage inner = outers[id].inners[msg.sender];
        inner.a = a;
        inner.b = b;
        inner.c = c;
    }

    function writeOnce(uint id, uint16 a, uint16 b, uint96 c) public {
        Inner memory inner = Inner({a: a, b: b, c: c});
        outers[id].inners[msg.sender] = inner;
    }
}
