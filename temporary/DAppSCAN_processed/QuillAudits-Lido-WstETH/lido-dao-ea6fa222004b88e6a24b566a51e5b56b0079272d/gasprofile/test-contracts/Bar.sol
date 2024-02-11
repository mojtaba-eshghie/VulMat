// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/gasprofile/test-contracts/Baz.sol

pragma solidity ^0.4.24;

contract Baz {
    function add (uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/gasprofile/test-contracts/Bar.sol

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
