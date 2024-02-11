// File: ../sc_datasets/DAppSCAN/QuillAudits-Empower the DAO-Empower the DAO/compound-aragon-app-b496ca40525a788bdc50f0dcc62bca48e86b6d36/compound-aragon-app-b496ca40525a788bdc50f0dcc62bca48e86b6d36/compound-protocol/test/contracts/DSValueHarness.sol

// Abstract contract for the full DSValue standard
// --
pragma solidity ^0.5.8;

contract DSValueHarness {
    bool public has;
    bytes32 public val;

    constructor(bytes32 initVal) public {
        if (initVal != 0) {
            has = true;
            val = initVal;
        }
    }

    function peek() public view returns (bytes32, bool) {
        return (val, has);
    }

    function read() public view returns (bytes32) {
        return val;
    }

    function set(bytes32 _val) public {
        val = _val;
        has = true;
    }

    function unset() public {
        has = false;
    }
}
