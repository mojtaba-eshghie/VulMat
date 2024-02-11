// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Lido Protocol/lido-dao-801d3e854efb33ff33a59fe51187e187047a6be2/gasprofile/test-contracts/Baz.sol

pragma solidity ^0.4.24;

contract Baz {
    function add (uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Lido Protocol/lido-dao-801d3e854efb33ff33a59fe51187e187047a6be2/gasprofile/test-contracts/Bar.sol

pragma solidity ^0.4.24;

contract Bar {
    uint s;
    Baz baz;

    constructor () public {
        baz = new Baz();
        s = baz.add(0, 0);
    }

    function bar (uint i) public returns (uint) {
        uint sum = baz.add(s, i);
        s = sum;
        return sum;
    }
}
