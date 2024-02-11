// File: ../sc_datasets/DAppSCAN/PeckShield-Venus/venus-protocol-48c7400f668116f5e5fa92299e28cf16b49b485c/tests/Contracts/Structs.sol

pragma solidity ^0.5.16;

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
